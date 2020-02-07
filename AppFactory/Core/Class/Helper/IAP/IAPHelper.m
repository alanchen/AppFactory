//
//  IAPHelper.m
//  PigMarket
//
//  Created by alan on 2018/6/7.
//  Copyright © 2018年 alan. All rights reserved.
//

#import "IAPHelper.h"

NSString * const kSandboxReceiptVerificationURL = @"https://sandbox.itunes.apple.com/verifyReceipt";
NSString * const kProductionReceiptVerificationURL = @"https://buy.itunes.apple.com/verifyReceipt";

@interface IAPHelper () <SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic,strong) NSMutableDictionary *paymentCallbackInfo;
@property (nonatomic,strong) NSMutableDictionary *productsCallbackInfo;

@end

@implementation IAPHelper

#pragma mark - Life Cycle

+(IAPHelper *)sharedInstance
{
    static IAPHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[IAPHelper alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Private

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self finishAllFailedTransactions];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    
    return self;
}

- (void)completeTheTransaction:(SKPaymentTransaction *)transaction
{
    NSString *productId = transaction.payment.productIdentifier;
    PaymentCallbackBlock transactionCallback = [self paymentCallbackById:productId];
    SKPaymentTransactionState state = transaction.transactionState;
    if(state == SKPaymentTransactionStatePurchased || state == SKPaymentTransactionStateRestored){
        if(transactionCallback){
            transactionCallback(transaction,nil);
        }
    }else{
        if(transactionCallback){
            transactionCallback(transaction,transaction.error);
        }
        [self finishTransaction:transaction];
    }
    
    [self removePaymentCallbackById:productId];
}

#pragma mark -

-(PaymentCallbackBlock)paymentCallbackById:(NSString *)productId
{
    if(!productId)
        return nil;
    
    return [self.paymentCallbackInfo objectForKey:productId];
}

-(void)setPaymentCallback:(PaymentCallbackBlock)block productId:(NSString *)productId
{
    if(!productId || !block)
        return ;
    
    [self.paymentCallbackInfo setObject:block forKey:productId];
}

-(void)removePaymentCallbackById:(NSString *)productId
{
    if(!productId)
        return ;
    
    return [self.paymentCallbackInfo removeObjectForKey:productId];
}

#pragma mark -  SKPaymentTransactionObserver

// Sent when the transaction array has changed (additions or state changes).
// Client should check state of transactions and finish as appropriate.
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions
{
    for (SKPaymentTransaction * transaction in transactions){
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Purchasing ...");
                break;
                
            case SKPaymentTransactionStatePurchased:
            case SKPaymentTransactionStateFailed:
            case SKPaymentTransactionStateRestored:
                [self completeTheTransaction:transaction];
                break;
                
            default:
                break;
        }
    };
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    self.products = response.products;
    NSString *key = [NSString stringWithFormat:@"%lu",(unsigned long)[request hash]];
    void (^callback)(NSArray *, NSArray *, NSError *) = [self.productsCallbackInfo objectForKey:key];
    if(callback){
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(response.products, response.invalidProductIdentifiers, nil);
        });
    }
}

- (void)requestDidFinish:(SKRequest *)request
{
    request.delegate = nil;
    NSString *key = [NSString stringWithFormat:@"%lu",(unsigned long)[request hash]];
    [self.productsCallbackInfo removeObjectForKey:key];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSString *key = [NSString stringWithFormat:@"%lu",(unsigned long)[request hash]];
    void (^callback)(NSArray *, NSArray *, NSError *) = [self.productsCallbackInfo objectForKey:key];
    if(callback){
        callback(nil, nil, error);
    }
    
    
    request.delegate = nil;
    [self.productsCallbackInfo removeObjectForKey:key];
}

#pragma mark - Public

- (void)productsWithIdentifiers:(NSSet *)identifiers
                     completion:(void (^)(NSArray *products, NSArray *invalidIdentifiers, NSError *error))completion
{
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:identifiers];
    request.delegate = self;
    if(completion){
        NSString *key = [NSString stringWithFormat:@"%lu",(unsigned long)[request hash]];
        [self.productsCallbackInfo setObject:completion forKey:key];
    }
    [request start];
}

- (void)purchaseAProduct:(SKProduct *)product
              completion:(PaymentCallbackBlock)completion
{
    if(!product){
        NSError *err = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:2 userInfo:nil];
        if(completion)
            completion(nil,err);
        return;
    }
    
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    [self setPaymentCallback:completion productId:payment.productIdentifier];
}

- (void)purchaseAProductWithIdentifier:(NSString *)identifier
                            completion:(PaymentCallbackBlock)completion
{
    SKProduct *product = [self productOfIdentifier:identifier];
    [self purchaseAProduct:product completion:completion];
}

- (NSString *)receiptDataString
{
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    NSString *dataStr = [receiptData base64EncodedStringWithOptions:0];
    return dataStr?dataStr:@"";
}

#pragma mark -

-(void)finishAllFailedTransactions
{
    NSArray *unfinishedTransactions = [self unfinishedTransactions];
    for (SKPaymentTransaction * transaction in unfinishedTransactions){
        if( transaction.error || transaction.transactionState == SKPaymentTransactionStateFailed){
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        }
    }
}

-(void)finishTransactionById:(NSString *)transactionId;
{
    NSArray *unfinishedTransactions = [self unfinishedTransactions];
    for (SKPaymentTransaction * transaction in unfinishedTransactions){
        if([transaction.transactionIdentifier isEqualToString:transactionId]){
            [self finishTransaction:transaction];
        }
    }
}

-(void)finishTransaction:(SKPaymentTransaction *)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)finishAllTransactions
{
    NSArray *unfinishedTransactions = [self unfinishedTransactions];
    for (SKPaymentTransaction * transaction in unfinishedTransactions){
        [self finishTransaction:transaction];
    }
}

-(NSArray *)unfinishedTransactions
{
    NSArray *unfinishedTransactions = [[SKPaymentQueue defaultQueue] transactions];
    return unfinishedTransactions;
}

-(BOOL)areThereUnfinishedTransactions
{
    NSArray *unfinishedTransactions = [self unfinishedTransactions];
    for (SKPaymentTransaction * transaction in unfinishedTransactions){
        if(transaction.transactionState == SKPaymentTransactionStatePurchased)
            return YES;
    }
    
    return NO;
}

-(SKPaymentTransaction *)transactionByProductId:(NSString *)productId
{
    NSArray *unfinishedTransactions = [self unfinishedTransactions];
    for (SKPaymentTransaction * transaction in unfinishedTransactions){
        if([transaction.payment.productIdentifier isEqualToString:productId]){
            return transaction;
        }
    }
    
    return nil;
}

#pragma mark -

- (SKProduct *)productOfIdentifier:(NSString *)identifier
{
    for(NSInteger index=0 ;index < [self.products count];index++){
        SKProduct *p = [self.products objectAtIndex:index];
        if([p.productIdentifier isEqualToString:identifier])
            return p;
    }
    
    return nil;
}

-(BOOL)isProductsReady
{
    return [self.products count]?YES:NO;
}

-(void)verifyReceiptWithPassword:(NSString *)password completion:(void (^)(NSDictionary *jsonResponse, NSError *error))completion
{
    password = password?password:@"";
    NSDictionary *requestContents = @{ @"receipt-data": [self receiptDataString], @"password": password};
    NSError *error;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents options:0 error:&error];
    
    if (!requestData || error) {
        if(completion) completion(nil,error);
        return;
    }
    
    NSURL *storeURL = [NSURL URLWithString:kSandboxReceiptVerificationURL];
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:storeRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        if (connectionError) {
            if(completion) completion(nil,connectionError);
            return;
        }
        
        NSError *err;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if (err) {
            if(completion) completion(nil,err);
            return;
        }
        
        if(completion) completion(jsonResponse,nil);
    }];
    [task resume];
}

#pragma mark - Setter & Getter

-(NSMutableDictionary *)paymentCallbackInfo
{
    if(!_paymentCallbackInfo){
        _paymentCallbackInfo = [NSMutableDictionary dictionary];
    }
    
    return _paymentCallbackInfo;
}

-(NSMutableDictionary *)productsCallbackInfo
{
    if(!_productsCallbackInfo){
        _productsCallbackInfo = [NSMutableDictionary dictionary];
    }
    
    return _productsCallbackInfo;
}

@end
