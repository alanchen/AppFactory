//
//  APNHelper.h
//  AppFactory
//
//  Created by alan on 2017/10/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APNModel.h"

@protocol APNHelperDelegate<NSObject>

@required
-(void)runInitWithModel:(APNModel *)model;
-(void)runInactiveHandlerWithModel:(APNModel *)model;
-(void)runActiveHandlerWithModel:(APNModel *)model;
-(void)runGotTokenHandler;

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
@property (nonatomic,strong) APNModel *launchedModel;

/**********************************************************************
 Put below snippets in where they should be
 **********************************************************************/

//  Consider 3 possible push notification delivery states:
//  Your app was just launched, use appDidLaunchWithOptions:
//  Your app was just brought from background to foreground
//  Your app was already running in the foreground

#pragma mark - Interface

-(void)appDidLaunchWithOptions:(NSDictionary *)launchOptions; // didFinishLaunchingWithOptions
-(void)appDidReceiveRemoteNotification:(NSDictionary *)userInfo; // didReceiveRemoteNotification:fetchCompletionHandler:
-(void)appDidRegisterToken:(NSData *)deviceToken; // didRegisterForRemoteNotificationsWithDeviceToken
-(void)userDidLoginWithCompletion:(void (^)(void))completion;

#pragma mark - Token

+ (BOOL)isAPNEnable;
+ (void)registerRemoteNotification;
+ (NSString *)parseToken:(NSData *)tokenData;
+ (void)saveTokenToDevice:(NSString *)token;
+ (NSString *)savedToken;
+ (BOOL)didIRegisterAPNToken;
+ (void)registeredAPNToken;

#pragma mark - Other

+ (void)gotoSettings;

@end
