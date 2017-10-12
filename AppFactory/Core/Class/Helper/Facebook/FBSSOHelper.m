//
//  FBSSOHelper.m
//  AppFactory
//
//  Created by alan on 2017/10/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "FBSSOHelper.h"
#import "DateTools.h"
#import "NSUserDefualtsMacros.h"
#import "LogMacros.h"
#import "NSMutableDictionary+AFExtension.h"
#import "NSObject+AFExtension.h"

static NSString *kFBUserData = @"FB_USER_DATA";
static NSString *kFBRefreshUserDataDate = @"FB_UPDATE_USER_DATE";

@implementation FBSSOHelper

#pragma mark - Permission

+ (NSArray *)defaultPermissionREAD
{
    return @[@"public_profile", @"email", @"user_friends"];
}

+ (NSString *)defaultUserFields
{
    return @"id,name,email,friends,picture.width(720).height(720),cover";
}

#pragma mark - Token

+ (NSString *)currentToken
{
    return [FBSDKAccessToken currentAccessToken].tokenString;
}

+ (BOOL) isCurrentTokenExpired
{
    NSDate *nowDate = [NSDate date];
    NSDate *FBExpiredDate = [[FBSDKAccessToken currentAccessToken] expirationDate];
    
    if(!FBExpiredDate)
        return YES;
    
    return [nowDate isLaterThan:FBExpiredDate];
}

+ (BOOL) isCurrentTokenEmpty
{
    if(![FBSDKAccessToken currentAccessToken])
        return YES;
    
    return NO;
}

#pragma mark - User

+ (NSDictionary *) currentUser{
    return NSUserDefaultsGetObj(kFBUserData);
}

+ (NSString *) currentUserId{
    NSDictionary *user = [self currentUser];
    return [user objectForKey:@"id"];
}

+ (NSDate *) lastRefreshUserDate{
    NSDate *date = NSUserDefaultsGetObj(kFBRefreshUserDataDate);
    return date;
}

+(void)logout
{
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    NSUserDefaultsSetObj(kFBUserData, nil);
    NSUserDefaultsSetObj(kFBRefreshUserDataDate, nil);
    NSUserDefaultsSaved;
}

#pragma mark - Public Methods

+ (void)connectWithComplete:(void (^)(BOOL success, id userData, id errInfo))complete
{
    [self fb_connectWithPermissionREAD:[self defaultPermissionREAD]
                            userFields:[self defaultUserFields]
                          withComplete:^(BOOL success, id result, id errInfo) {
                              complete(success, result, errInfo);
                          }];
}

+ (void)refreshUserDataWithCompletion:(void (^)(NSDictionary *user))completion
{
    if([self isCurrentTokenEmpty]){
        if(completion) completion(nil);
        return;
    }
    
    [self fb_refreshTokenWithCompletion:^(NSError *error, id result) {
        if([self isCurrentTokenEmpty] || [self isCurrentTokenExpired]){
            if(completion) completion(nil);
            return ;
        }
        [self fb_fetchUserWithFields:[self defaultUserFields] withComplete:^(id result, NSError *error) {
            BOOL success = error?NO:YES;
            if (success) {
                NSUserDefaultsSetObj(kFBRefreshUserDataDate, [NSDate date]);
                NSUserDefaultsSaved;
                if(completion) completion(result);
            }else{
                if(completion) completion(nil);
            }
        }];
    }];
}

+ (void) reconnectIfNeed:(void (^)(BOOL success))complete
{
    if(![self isCurrentTokenEmpty]){
        complete(YES);
        return;
    }

    [self fb_connectWithPermissionREAD:[self defaultPermissionREAD]
                            userFields:[self defaultUserFields]
                          withComplete:^(BOOL success, id result, id errInfo) {
        complete(success);
    }];
}

#pragma mark - Private Methods

+ (void)fb_connectWithPermissionREAD:(NSArray *)permissionREAD userFields:(NSString *)userFields withComplete:(void (^)(BOOL success, id result, id errInfo))complete
{
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    NSUserDefaultsSetObj(kFBUserData, nil);
    NSUserDefaultsSetObj(kFBRefreshUserDataDate, nil);
    NSUserDefaultsSaved;
    
    [loginManager logInWithReadPermissions:permissionREAD
                        fromViewController:nil
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error) {
             if(complete) complete(NO ,nil, nil);
             DLog(@"FB Login Process error:%@", error);
             return ;
         }
         
         if (result.isCancelled) {
             if(complete)  complete(NO ,nil, nil);
             DLog(@"FB Login was Cancelled by user");
             return ;
         }
         if (result.isDeclinedPermissions) {
             if(complete) complete(NO ,nil, [result declinedErrorWithREADPermission:permissionREAD]);
             return ;
         }
         
         [self fb_fetchUserWithFields:userFields withComplete:^( id result, NSError *error) {
             BOOL success = !error;
             if(complete)  complete(success ,result, nil);
         }];
     }];
}

+ (void)fb_fetchUserWithFields:(NSString *)userFields withComplete:(void (^)(id result, NSError *error))completion
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:userFields forKey:@"fields"];
    
    FBSDKGraphRequest *req = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters];
    
    [req startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        BOOL success = !error;
        if (success) {
            NSString *cover = [[result safelyObjectForKey:@"cover"] safelyObjectForKey:@"source"];
            NSString *picture = [[[result safelyObjectForKey:@"picture"] safelyObjectForKey:@"data"] safelyObjectForKey:@"url"];
            NSMutableDictionary *userData = [result mutableCopy];
            [userData safelySetObject:cover forKey:@"cover"];
            [userData safelySetObject:picture forKey:@"picture"];
            if(userData){
                NSUserDefaultsSetObj(kFBUserData, userData);
                NSUserDefaultsSaved;
            }
            if(completion) completion(userData, error);
        }else{
            if(completion) completion(nil, error);
        }
    }];
}

+ (void)fb_refreshTokenWithCompletion:(void (^)(NSError *error, id result))completion;
{
    if(![self isCurrentTokenExpired]){
        completion(nil, nil);
        return;
    }
    
    [FBSDKAccessToken refreshCurrentAccessToken:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        completion(error, result);
    }];
}

@end
