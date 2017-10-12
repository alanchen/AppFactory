//
//  AFHTTPSessionManager+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/5.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFHTTPSessionManager+AFExtension.h"
#import "ObjcAssociatedObjectHelpers.h"

typedef void (^PostHandlerBlockType)(AFApiResponse *res);
static const char PostHandlerBlockKey;

@implementation AFHTTPSessionManager(AFExtension)

+(AFHTTPSessionManager *)newDefaultManager
{
    AFHTTPSessionManager *manager= [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer * requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPResponseSerializer * responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = responseSerializer;
    manager.requestSerializer = requestSerializer;
    
    return manager;
}

+(AFHTTPSessionManager *)newManagerWithBaseUrl:(NSString *)urlStr
{
    NSURL *baseUrl = [NSURL URLWithString:urlStr];

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 20;
    
    AFJSONRequestSerializer *reqSerializer = [AFJSONRequestSerializer serializer];
    reqSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    AFJSONResponseSerializer *resSerializer = [AFJSONResponseSerializer serializer];
    resSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl sessionConfiguration:config];
    manager.responseSerializer = resSerializer;
    manager.requestSerializer = reqSerializer;
    
    return manager;
}
-(void)setReqHeader:(NSString *)value key:(NSString *)key
{
    if(!value || !key) return;
    [self.requestSerializer setValue:value forHTTPHeaderField:key];
}

-(void)setAuthorizationToken:(NSString *)token
{
    [self.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
}

-(void)setXAuthorizationToken:(NSString *)token
{
    [self.requestSerializer setValue:token forHTTPHeaderField:@"X-Authorization"];
}

-(void)setCompletionHandlerBlock:(void (^)(AFApiResponse *resObj))block
{
    if (block){
        objc_setAssociatedObject(self, &PostHandlerBlockKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark -

-(NSURLSessionDataTask *)GET:(NSString *)path
                      params:(id)params
                    progress:(void (^)(NSProgress * progress))downloadProgress
                  completion:(void (^)(AFApiResponse *res))completion
{
    return [self GET:path parameters:params progress:downloadProgress
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [self resHandler:responseObject task:task error:nil completion:completion];
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [self resHandler:nil task:task error:error completion:completion];
             }];
}

-(NSURLSessionDataTask *)GET:(NSString *)path
                      params:(id)params
                  completion:(void (^)(AFApiResponse *res))completion
{
    return [self GET:path params:params progress:nil completion:completion];
}

-(NSURLSessionDataTask *)POST:(NSString *)path
                      params:(id)params
                    progress:(void (^)(NSProgress * progress))uploadProgress
                  completion:(void (^)(AFApiResponse *res))completion
{
    return [self POST:path parameters:params progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self resHandler:responseObject task:task error:nil completion:completion];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self resHandler:nil task:task error:error completion:completion];
    }];
}

-(NSURLSessionDataTask *)POST:(NSString *)path
                       params:(id)params
                   completion:(void (^)(AFApiResponse *res))completion
{
    return [self POST:path params:params progress:nil completion:completion];
}

-(NSURLSessionDataTask *)POST:(NSString *)path
                       params:(id)params
    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                     progress:(void (^)(NSProgress * progress))uploadProgress
                   completion:(void (^)(AFApiResponse *res))completion
{
    return [self POST:path parameters:params constructingBodyWithBlock:block progress:uploadProgress
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  [self resHandler:responseObject task:task error:nil completion:completion];
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  [self resHandler:nil task:task error:error completion:completion];
              }];
}

-(NSURLSessionDataTask *)DELETE:(NSString *)path
                         params:(id)params
                     completion:(void (^)(AFApiResponse *res))completion
{
    return [self DELETE:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self resHandler:responseObject task:task error:nil completion:completion];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self resHandler:nil task:task error:error completion:completion];
    }];
}

-(NSURLSessionDataTask *)PUT:(NSString *)path
                      params:(id)params
                  completion:(void (^)(AFApiResponse *res))completion
{
    return [self PUT:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self resHandler:responseObject task:task error:nil completion:completion];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self resHandler:nil task:task error:error completion:completion];
    }];
}

#pragma mark - Private

-(void)resHandler:(id)resObj task:(NSURLSessionDataTask *)task error:(NSError *)error completion:(void (^)(AFApiResponse *))completion
{
    AFApiResponse *res = [AFApiResponse responseWithTask:task res:resObj error:error];
    if(completion){completion(res);}
    PostHandlerBlockType block = objc_getAssociatedObject(self, &PostHandlerBlockKey);
    if(block){block(res);}
}

@end
