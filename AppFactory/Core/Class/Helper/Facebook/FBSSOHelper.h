//
//  FBSSOHelper.h
//  AppFactory
//
//  Created by alan on 2017/10/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "FBSDKLoginManagerLoginResult+AFExtension.h"
#import "NSError+SSOHelper.h"

@interface FBSSOHelper : NSObject

#pragma mark - Token
+ (NSString *) currentToken;
+ (BOOL) isCurrentTokenExpired;
+ (BOOL) isCurrentTokenEmpty;

#pragma mark - User
+ (NSDictionary *) currentUser;
+ (NSString *) currentUserId;
+ (NSDate *) lastRefreshUserDate;
+ (void)logout;

#pragma mark - Main
+ (void) connectWithPermissionREAD:(NSArray *)permission
                        userFields:(NSString *)userFields
                          complete:(void (^)(BOOL success, id userData, NSError *err))complete;

+ (void) connectWithComplete:(void (^)(BOOL success, id userData, NSError *err))complete;
+ (void) refreshUserDataWithCompletion:(void (^)(NSDictionary *user))completion;
+ (void) reconnectIfNeed:(void (^)(BOOL success))complete;

@end
