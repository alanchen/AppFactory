//
//  IAPHelper.h
//  PigMarket
//
//  Created by alan on 2018/6/7.
//  Copyright © 2018年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

typedef void (^PaymentCallbackBlock)(SKPaymentTransaction *transaction, NSError *error);

@interface IAPHelper : NSObject
@property (nonatomic,strong) NSArray *products; // cached in memory

+(IAPHelper *)sharedInstance;

#pragma mark -

- (void)productsWithIdentifiers:(NSSet *)identifiers
                     completion:(void (^)(NSArray *products, NSArray *invalidIdentifiers, NSError *error))completion;

- (void)purchaseAProduct:(SKProduct *)product
              completion:(PaymentCallbackBlock) completion;

- (void)purchaseAProductWithIdentifier:(NSString *)identifier
                            completion:(PaymentCallbackBlock) completion;

- (NSString *)receiptDataString;

#pragma mark - Transactions

-(void)finishAllFailedTransactions;
-(void)finishTransactionById:(NSString *)transactionId;
-(void)finishTransaction:(SKPaymentTransaction *)transaction;
-(void)finishAllTransactions;
-(NSArray *)unfinishedTransactions;
-(BOOL)areThereUnfinishedTransactions;
-(SKPaymentTransaction *)transactionByProductId:(NSString *)productId; // This is an unfinished transaction.

#pragma mark -

-(SKProduct *)productOfIdentifier:(NSString *)identifier;
-(BOOL)isProductsReady;
-(void)verifyReceiptWithPassword:(NSString *)password completion:(void (^)(NSDictionary *jsonResponse, NSError *error))completion;

@end
