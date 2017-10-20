//
//  FBSSOHelper.h
//  AppFactory
//
//  Created by alan on 2017/10/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBSSOResult.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

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
                          complete:(void (^)(FBSSOResult *result))complete;

+ (void) connectWithComplete:(void (^)(FBSSOResult *result))complete;
+ (void) refreshUserDataWithCompletion:(void (^)(NSDictionary *user))completion;
+ (void) reconnectIfNeed:(void (^)(BOOL success))complete;

#pragma mark - Must Have
// - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
+(void)application:(UIApplication *)application didLaunch:(NSDictionary *)launchOptions;
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
+(BOOL)application:(UIApplication *)application url:(NSURL *)url sourceApp:(NSString *)sourceApp annotation:(id)annotation;

@end

