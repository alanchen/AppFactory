//
//  APNHelper.h
//  AppFactory
//
//  Created by alan on 2017/10/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APNModel.h"
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//#import <UserNotifications/UserNotifications.h>
//#endif

@protocol APNHelperDelegate<NSObject>

@required
-(void)setupAfterCreateModel:(APNModel *)model;
-(void)launchAppWithModel:(APNModel *)model;
-(void)bringAppToForegroundWithModel:(APNModel *)model;
-(void)recieveInForegroundWithModel:(APNModel *)model;
-(void)gotTokenHandler:(NSString *)token;

@optional
-(Class)modelClass; // subcalss of APNModel
-(NSString *)alertAllowPermissionMessage;
-(NSString *)alertSettingOpenMessage;
-(NSString *)alertTitle;
-(NSString *)alertCancel;
-(NSString *)alertOpen;

@end

@interface APNHelper : NSObject

+(id)sharedInstance;

/**********************************************************************
 Put below snippets in where they should be
 **********************************************************************/

//  Consider 3 possible push notification delivery states:
//  Your app was just launched, use appDidLaunchWithOptions:
//  Your app was just brought from background to foreground
//  Your app was already running in the foreground

#pragma mark - Interface

// Put in didFinishLaunchingWithOptions
-(void)appDidLaunchWithOptions:(NSDictionary *)launchOptions;

// Put in didRegisterForRemoteNotificationsWithDeviceToken
-(void)appDidRegisterToken:(NSData *)deviceToken;

// If below iOS10, put in didReceiveRemoteNotification:fetchCompletionHandler:
-(void)appDidReceiveRemoteNotification:(NSDictionary *)userInfo;

// Use it if user needs login. Also ask for push token
-(void)runWhenYouAreReadyWithCompletion:(void (^)(void))completion;

#pragma mark - Token

+ (void)isNotificationAuthorized:(void(^)(BOOL isEnable))completion;
+ (void)registerRemoteNotification;

+ (NSString *)parseToken:(NSData *)tokenData;
+ (void)saveTokenToDevice:(NSString *)token;
+ (NSString *)savedToken;

+ (BOOL)didIAskForPushAuthorization;
+ (void)setAlreadyAskForPushAuthorization;

#pragma mark - Other

+ (void)gotoSettings;

@end
