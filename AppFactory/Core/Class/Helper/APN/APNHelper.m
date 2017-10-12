//
//  APNHelper.m
//  AppFactory
//
//  Created by alan on 2017/10/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "APNHelper.h"
#import "UsefulDefinition.h"
#import "NSUserDefualtsMacros.h"
#import "UIAlertController+AFExtension.h"
#import "DeviceMacros.h"
#import "UIApplication+AFExtension.h"

@implementation APNHelper

+(id)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - App

- (void)appDidLaunchWithOptions:(NSDictionary *)launchOptions
{
    if (launchOptions){
        NSDictionary *remoteNotif  = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        APNModel *model = [APNModel modelWithNotification:remoteNotif];
        self.launchedModel = model;
    }
}

-(void)appDidReceiveRemoteNotification:(NSDictionary *)userInfo
{
    APNModel *model = [APNModel modelWithNotification:userInfo];
    [self runInitWithModel:model];
    
    BOOL launchedFromBackground = ![SHARED_APP isAppActive];
    if(launchedFromBackground){
        [self runInactiveHandlerWithModel:model];
    }else{
        [self runActiveHandlerWithModel:model];
    }
}

- (void)appDidRegisterToken:(NSData *)deviceToken
{
    if(!deviceToken) return;
    NSString *token = [APNHelper parseToken:deviceToken];
    if(token){
        [APNHelper saveTokenToDevice:token];
        [self runGotTokenHandler];
    }
}

-(void)userDidLoginWithCompletion:(void (^)(void))completion
{
    if(self.launchedModel){
        [self runInitWithModel:self.launchedModel];
        [self runInactiveHandlerWithModel:self.launchedModel];
        self.launchedModel = nil;
        if(completion) completion();
        return;
    }
    
    /////////////////////////
    if([APNHelper isAPNEnable]){
        [APNHelper registerRemoteNotification];
        [APNHelper registeredAPNToken];
        if(completion) completion();
        return;
    }
    
    /////////////////////////
    NSString *title = @"為了即時通知您訊息";
    RUN_SELECTOR_WITH_RETURN_VALUE_IF_VALID(self.delegate, alertMessageTitle, title);
     // see this alert at first time only
    if(![APNHelper didIRegisterAPNToken]){
        NSString *msg = [NSString stringWithFormat:@"\n%@，\n\n請允許「%@」傳送通知給您。", title, INFO_APP_NAME];
        [UIAlertController showWithTitle:@"開啟「通知」功能" message:msg buttonTitle:@"OK" handler:^(UIAlertAction *action) {
            [APNHelper registerRemoteNotification];
            [APNHelper registeredAPNToken];
            if(completion) completion();
        }];
        
        return;
    }
    
    /////////////////////////
    NSString *msg = [NSString stringWithFormat:@"\n%@，\n\n請至「設定」開啟「通知」功能。", title];
    [UIAlertController showAlertViewWithTitle:@"開啟「通知」功能" message:msg cancelTitle:@"取消" otherTitle:@"前往開啟"  cancelHandler:^(UIAlertAction *action) {
        if(completion) completion();
    } otherHandler:^(UIAlertAction *action) {
         [APNHelper gotoSettings];
        if(completion) completion();
    }];
}

#pragma mark - APNHelperDelegate

-(void)runInitWithModel:(APNModel *)model
{
    //Implement
}

-(void)runInactiveHandlerWithModel:(APNModel *)model
{
    //Implement
}

-(void)runActiveHandlerWithModel:(APNModel *)model
{
    //Implement
}

-(void)runGotTokenHandler
{
    //Implement
}

#pragma mark - Token

// http://stackoverflow.com/questions/1535403/
+ (BOOL)isAPNEnable
{
    BOOL isAPNSForbidden = NO;
    UIUserNotificationSettings* settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    UIUserNotificationType types = settings.types;
    isAPNSForbidden = types == UIUserNotificationTypeNone ? YES:NO;
    
    return !isAPNSForbidden;
}

+ (void)registerRemoteNotification
{
    UIApplication *application = [UIApplication sharedApplication];
    
    UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    UIUserNotificationSettings* settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [application registerUserNotificationSettings:settings];
}

+ (NSString *)parseToken:(NSData *)tokenData
{
    if(!tokenData)
        return nil;
    
    NSString *deviceToken = [[[[tokenData description]
                               stringByReplacingOccurrencesOfString: @"<" withString: @""]
                              stringByReplacingOccurrencesOfString: @">" withString: @""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    
    return deviceToken;
}

+ (void)saveTokenToDevice:(NSString *)token{
    if(token){
        NSUserDefaultsSetObj(@"APNS_TOKEN", token);
        NSUserDefaultsSaved;
    }
}

+ (NSString *)savedToken
{
    NSString *token = NSUserDefaultsGetObj(@"APNS_TOKEN");
    return token;
}

+ (BOOL)didIRegisterAPNToken{
    return NSUserDefaultsGetBool(@"didIRegisterAPNToken");
}

+ (void)registeredAPNToken{
    NSUserDefaultsSetBool(@"didIRegisterAPNToken", YES);
    NSUserDefaultsSaved;
}

#pragma mark - Other

+ (void)gotoSettings
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end
