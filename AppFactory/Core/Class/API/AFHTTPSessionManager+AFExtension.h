//
//  AFHTTPSessionManager+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/5.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFApiResponse.h"
#import "LibsHeader.h"

@interface AFHTTPSessionManager(AFExtension)

+(AFHTTPSessionManager *)newDefaultManager;

+(AFHTTPSessionManager *)newManagerWithBaseUrl:(NSString *)urlStr;

-(void)setCompletionHandlerBlock:(void (^)(AFApiResponse *resObj))block;

-(void)setReqHeader:(NSString *)value key:(NSString *)key;
-(void)setAuthorizationToken:(NSString *)token;
-(void)setXAuthorizationToken:(NSString *)token;

-(NSURLSessionDataTask *)GET:(NSString *)path
                      params:(id)params
                    progress:(void (^)(NSProgress * progress))downloadProgress
                  completion:(void (^)(AFApiResponse *res))completion;

-(NSURLSessionDataTask *)GET:(NSString *)path
                      params:(id)params
                  completion:(void (^)(AFApiResponse *res))completion;
-(NSURLSessionDataTask *)POST:(NSString *)path
                       params:(id)params
                     progress:(void (^)(NSProgress * progress))uploadProgress
                   completion:(void (^)(AFApiResponse *res))completion;

-(NSURLSessionDataTask *)POST:(NSString *)path
                       params:(id)params
                   completion:(void (^)(AFApiResponse *res))completion;

-(NSURLSessionDataTask *)POST:(NSString *)path
                       params:(id)params
    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                     progress:(void (^)(NSProgress * progress))uploadProgress
                   completion:(void (^)(AFApiResponse *res))completion;

-(NSURLSessionDataTask *)DELETE:(NSString *)path
                         params:(id)params
                     completion:(void (^)(AFApiResponse *res))completion;

-(NSURLSessionDataTask *)PUT:(NSString *)path
                      params:(id)params
                  completion:(void (^)(AFApiResponse *res))completion;

@end
