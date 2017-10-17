//
//  NSError+SSOHelper.m
//  AppFactory
//
//  Created by alan on 2017/10/17.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "NSError+SSOHelper.h"
#import "NSObject+AFExtension.h"
#import "NSMutableDictionary+AFExtension.h"

@implementation  NSError(SSOHelper)

- (NSString *)ssoErrorTitle
{
   return [self.userInfo safelyObjectForKey:@"title"];
}

- (NSString *)ssoErrorMessage
{
    return [self.userInfo safelyObjectForKey:@"msg"];
}

+ (NSError *)errorSSOWithTitle:(NSString *)title message:(NSString *)msg
{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info safelySetObject:title forKey:@"title"];
    [info safelySetObject:msg forKey:@"msg"];
    return [NSError errorWithDomain:@"fb.sso.helper" code:0 userInfo:info];
}

+ (NSError *)errorSSOWithUserInfo:(NSDictionary *)info
{
    return [NSError errorWithDomain:@"fb.sso.helper" code:0 userInfo:info];
}

@end
