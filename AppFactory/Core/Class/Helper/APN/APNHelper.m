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
#import "AnyPromise+AFExtension.h"

@interface APNHelper()
@property (nonatomic,strong) APNModel *launchedModel;
@end

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
    [self setupAfterCreateModel:model];
    return model;
}

#pragma mark - App

- (void)appDidLaunchWithOptions:(NSDictionary *)launchOptions
{
    if (launchOptions){
        NSDictionary *remoteNoti  = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        APNModel *model = [self createModelWithNotification:remoteNoti];
        self.launchedModel = model;
        [self launchAppWithModel:model];
    }
}

-(void)appDidReceiveRemoteNotification:(NSDictionary *)userInfo
{
    APNModel *model = [self createModelWithNotification:userInfo];
    BOOL launchedFromBackground = ![SHARED_APP isAppActive];
    if(launchedFromBackground){
        [self bringAppToForegroundWithModel:model];
    }else{
        [self recieveInForegroundWithModel:model];
    }
}

- (void)appDidRegisterToken:(NSData *)deviceToken
{
    if(!deviceToken) return;
    NSString *token = [[self class] parseToken:deviceToken];
    if(token){
        [[self class] saveTokenToDevice:token];
        [self gotTokenHandler:token];
    }
}

-(void)runWhenYouAreReadyWithCompletion:(void (^)(void))completion
{
    if(self.launchedModel){
        [self setupAfterCreateModel:self.launchedModel];
        [self bringAppToForegroundWithModel:self.launchedModel];
        self.launchedModel = nil;
        if(completion) completion();
        return ;
    }
    
    NSError *jumpToEnd = [NSError errorWithDomain:@"push.end" code:99 userInfo:nil];
    [AnyPromise promiseStart:^(PMKResolver resolve){
        [[self class] isNotificationAuthorized:^(BOOL isEnable) {
            if(isEnable){
                [[self class] registerRemoteNotification];
                resolve(jumpToEnd);
            }else{
                resolve(nil);
            }
        }];
    }].thenWithANewPromise(^(PMKResolver resolve, id data){
        if(![[self class] didIAskForPushAuthorization]){
            [UIAlertController showWithTitle:[self alertTitle] message:[self alertAllowPermissionMessage] buttonTitle:@"OK" handler:^(UIAlertAction *action) {
                [[self class] registerRemoteNotification];
                resolve(jumpToEnd);
            }];
        }else{
            resolve(nil);
        }
    }).thenWithANewPromise(^(PMKResolver resolve, id data){
        [UIAlertController showAlertViewWithTitle:[self alertTitle] message:[self alertSettingOpenMessage] cancelTitle:[self alertCancel] otherTitle:[self alertOpen] cancelHandler:^(UIAlertAction *action) {
            resolve(jumpToEnd);
        } otherHandler:^(UIAlertAction *action) {
            [[self class] gotoSettings];
            resolve(jumpToEnd);
        }];
    }).catch(^(NSError *err){
        
    }).always(^(){
        if(completion)
            completion();
    });
}

#pragma mark - APNHelperDelegate

-(void)setupAfterCreateModel:(APNModel *)model
{
    //Implement
}

-(void)launchAppWithModel:(APNModel *)model
{
    //Implement
}

-(void)bringAppToForegroundWithModel:(APNModel *)model
{
    //Implement
}

-(void)bringAppToForegroundWithModel:(APNModel *)model action:(NSString *)action
{
    //Implement
}

-(void)recieveInForegroundWithModel:(APNModel *)model
{
    //Implement
}

-(void)gotTokenHandler:(NSString *)token
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

//#pragma mark - UNUserNotificationCenterDelegate
//
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler __IOS_AVAILABLE(10.0)
//{
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        NSDictionary * userInfo = notification.request.content.userInfo;
//        APNModel *model = [self createModelWithNotification:userInfo];
//        [self recieveInForegroundWithModel:model];
//    }
//
//    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
//}
//
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler __IOS_AVAILABLE(10.0)
//{
//    UNNotificationRequest *request = response.notification.request;
//    UNNotificationContent *content = request.content;
//    NSDictionary *userInfo = content.userInfo;
//
//    APNModel *model = [self createModelWithNotification:userInfo];
//    [self bringAppToForegroundWithModel:model action:response.actionIdentifier];
//    completionHandler();
//}

#pragma mark - Token

+ (void)isNotificationAuthorized:(void(^)(BOOL isEnable))completion;
{
//    if (@available(iOS 10, *)) {
//        UNUserNotificationCenter *center ;
//        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//            if(completion)
//                completion(settings.authorizationStatus == UNAuthorizationStatusAuthorized);
//        }];
//    }else{
        // http://stackoverflow.com/questions/1535403/
        UIUserNotificationSettings* settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        UIUserNotificationType types = settings.types;
        if(completion)
            completion(types != UIUserNotificationTypeNone);
//    }
}

+ (void)registerRemoteNotification
{
    [[self class] setAlreadyAskForPushAuthorization];

//    if (@available(iOS 10, *)) {
//        UNAuthorizationOptions options = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
//        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//        center.delegate = [self sharedInstance];
//        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {}];
//    }else{
        UIApplication *application = [UIApplication sharedApplication];
        [application registerForRemoteNotifications];
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings* settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [application registerUserNotificationSettings:settings];
//    }
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

+ (BOOL)didIAskForPushAuthorization{
    return NSUserDefaultsGetBool(@"didIRegisterAPNToken");
}

+ (void)setAlreadyAskForPushAuthorization{
    NSUserDefaultsSetBool(@"didIRegisterAPNToken", YES);
    NSUserDefaultsSaved;
}

#pragma mark - Other

+ (void)gotoSettings
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end
