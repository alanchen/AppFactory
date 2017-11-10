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

#pragma mark - Private

-(id)createModelWithNotification:(NSDictionary *)remoteNoti
{
    Class modelClass = [self modelClass];
    APNModel *model = [modelClass modelWithNotification:remoteNoti];
    return model;
}

#pragma mark - App

- (void)appDidLaunchWithOptions:(NSDictionary *)launchOptions
{
    if (launchOptions){
        NSDictionary *remoteNoti  = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        APNModel *model = [self createModelWithNotification:remoteNoti];
        self.launchedModel = model;
    }
}

-(void)appDidReceiveRemoteNotification:(NSDictionary *)userInfo
{
    APNModel *model = [self createModelWithNotification:userInfo];
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
    // see this alert at first time only
    if(![APNHelper didIRegisterAPNToken]){
        [UIAlertController showWithTitle:[self alertTitle] message:[self alertAllowPermissionMessage] buttonTitle:@"OK" handler:^(UIAlertAction *action) {
            [APNHelper registerRemoteNotification];
            [APNHelper registeredAPNToken];
            if(completion) completion();
        }];
        
        return;
    }
    
    /////////////////////////
    [UIAlertController showAlertViewWithTitle:[self alertTitle] message:[self alertSettingOpenMessage] cancelTitle:[self alertCancel] otherTitle:[self alertOpen] cancelHandler:^(UIAlertAction *action) {
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

#pragma mark -

-(Class)modelClass
{
    //Implement
    return [APNModel class];
}

-(NSString *)alertAllowPermissionMessage{
    return [NSString stringWithFormat:@"\n為了即時通知您訊息，\n\n請允許「%@」傳送通知給您。", INFO_APP_NAME];
}

-(NSString *)alertSettingOpenMessage{
    return  @"\n為了即時通知您訊息，\n\n請至「設定」開啟「通知」功能。";
}

-(NSString *)alertTitle{
    return @"開啟「通知」功能";
}

-(NSString *)alertCancel{
    return @"取消";
}

-(NSString *)alertOpen{
    return @"前往開啟";
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
