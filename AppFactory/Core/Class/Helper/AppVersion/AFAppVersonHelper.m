//
//  AFAppVersonHelper.m
//  AppFactory
//
//  Created by alan on 2017/10/6.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFAppVersonHelper.h"
//#import "NSUserDefualtsMacros.h"
//#import "DeviceMacros.h"
//#import "UIAlertController+AFExtension.h"
//#import "NSString+AFExtension.h"
//#import "UsefulDefinition.h"

//static NSString *const AppStoreVersionKey = @"AppStoreVersionKey";
//
//@interface AFAppVersonHelper() <iVersionDelegate>
//@property (nonatomic,strong) NSString *appId;
//@property (nonatomic,strong) UIAlertController *alertController;

//@end

@implementation AFAppVersonHelper

//+(AFAppVersonHelper *)sharedInstance
//{
//    static AFAppVersonHelper *sharedInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[AFAppVersonHelper alloc] init];
//    });
//
//    return sharedInstance;
//}
//
//+ (void)configWithAppId:(NSString *)appId
//{
//    [self sharedInstance].appId = appId;
//    [iVersion sharedInstance].appStoreID = [appId integerValue];
//    [iVersion sharedInstance].delegate = [self sharedInstance];
//}
//
//+ (NSString *)appStoreAppId
//{
//    NSString *appid = [self sharedInstance].appId;
//    return  appid;
//}
//
//+(void)openAppleStore
//{
//    NSString *iTunesLink = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/apple-store/id%@?mt=8",[self appStoreAppId]];
//    NSURL *url = [NSURL URLWithString:iTunesLink];
//    [[UIApplication sharedApplication] openURL:url];
//}
//
//+ (NSString *) appleStoreVersion
//{
//    NSString *localAppStoreVer = NSUserDefaultsGetObj(AppStoreVersionKey);
//    if(!localAppStoreVer || [INFO_APP_VERSION isVersionHigherThanVersion:localAppStoreVer] ){
//        NSUserDefaultsSetObj(AppStoreVersionKey, INFO_APP_VERSION);
//        NSUserDefaultsSaved;
//        return INFO_APP_VERSION;
//    }
//
//    return localAppStoreVer;
//}
//
//+ (BOOL)checkAndUpdateVersionWithTitle:(NSString *)title
//                               message:(NSString *)message
//                               goTitle:(NSString *)goTitle
//                          nextimeTitle:(NSString *)nextimeTitle
//                           serverBuild:(NSInteger )serverBuildNumber
//                     serverBuildForced:(NSInteger )serverBuildNumberForce
//                          forcedUpdate:(void (^)(void))forcedBlock
//                        optionalUpdate:(void (^)(void))optionalBlock
//                        nextTimeUpdate:(void (^)(void))nextTimeBlock
//{
//    message = NULL_TEST(message, @"已有新版本，請至AppleStore更新！");
//    goTitle = NULL_TEST(goTitle, @"前往更新");
//    nextimeTitle = NULL_TEST(nextimeTitle, @"下次更新");
//
//    NSInteger localBuildNumber = [INFO_BUILD_NUMBER integerValue];
//    BOOL isForceUpdate = serverBuildNumberForce > localBuildNumber ;
//    BOOL isOptionalUpdate = serverBuildNumber > localBuildNumber ;
//
//    if(isForceUpdate){
//        if(![self sharedInstance].alertController){
//            [self sharedInstance].alertController =
//            [UIAlertController showWithTitle:title message:message buttonTitle:goTitle handler:^(UIAlertAction *action) {
//                [self openAppleStore];
//                if(forcedBlock){ forcedBlock(); }
//                [self sharedInstance].alertController = nil;
//            }];
//        }
//
//        return YES;
//    }
//
//    if (isOptionalUpdate){
//        if(![self sharedInstance].alertController){
//            [self sharedInstance].alertController =
//            [UIAlertController showAlertViewWithTitle:title message:message cancelTitle:nextimeTitle otherTitle:goTitle cancelHandler:^(UIAlertAction *action) {
//                 if(nextTimeBlock){ nextTimeBlock(); }
//                [self sharedInstance].alertController = nil;
//            } otherHandler:^(UIAlertAction *action) {
//                [self openAppleStore];
//                if(optionalBlock){ optionalBlock(); }
//                [self sharedInstance].alertController = nil;
//            }];
//        }
//        return YES;
//    }
//
//    return NO;
//}
//
//#pragma mark - iVersionDelegate
//
//- (BOOL)iVersionShouldDisplayCurrentVersionDetails:(NSString *)versionDetails{
//    return NO;
//}
//
//- (BOOL)iVersionShouldDisplayNewVersion:(NSString *)version details:(NSString *)versionDetails{
//    return NO;
//}
//
//- (void)iVersionDidDetectNewVersion:(NSString *)version details:(NSString *)versionDetails
//{
//    NSString *localAppleStoreVersion = [AFAppVersonHelper appleStoreVersion];
//    NSString *remoteAppleStoreVersion = version;
//    [remoteAppleStoreVersion isVersionHigherThanVersion:localAppleStoreVersion];
//
//    if( [remoteAppleStoreVersion isVersionHigherThanVersion:localAppleStoreVersion] ){
//        NSUserDefaultsSetObj(AppStoreVersionKey, version);
//        NSUserDefaultsSaved;
//    }
//}

@end
