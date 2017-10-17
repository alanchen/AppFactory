//
//  NSError+SSOHelper.h
//  AppFactory
//
//  Created by alan on 2017/10/17.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError(SSOHelper)

- (NSString *)ssoErrorTitle;
- (NSString *)ssoErrorMessage;

+ (NSError *)errorSSOWithTitle:(NSString *)title message:(NSString *)msg;
+ (NSError *)errorSSOWithUserInfo:(NSDictionary *)info;

@end
