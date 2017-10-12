//
//  FBSDKLoginManagerLoginResult+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "FBSDKLoginManagerLoginResult+AFExtension.h"

@implementation FBSDKLoginManagerLoginResult(AFExtension)

-(BOOL)isDeclinedPermissions{
    return [self.declinedPermissions count]>0?YES:NO;
}

-(NSDictionary *)declinedErrorWithREADPermission:(NSArray *)permission
{
    if ([permission containsObject:@"email"] && [self.declinedPermissions containsObject:@"email"]) {
        return @{@"title":@"Facebook 授權不完整", @"msg":@"\n為提供最佳的使用者體驗，\n\n請提供 Email 授權。"};
    }
    
    if ([permission containsObject:@"user_friends"] && [self.declinedPermissions containsObject:@"user_friends"]) {
        return @{@"title":@"Facebook 授權不完整", @"msg":@"\n為提供最佳的使用者體驗，\n\n請提供 Friend List 授權。"};
    }
    
    NSString *unknownDeclinedPermission = [self.declinedPermissions anyObject];
    if (unknownDeclinedPermission) {
        NSString *msg = [NSString stringWithFormat:@"\n為提供最佳的使用者體驗，\n\n請提供 %@ 授權。",unknownDeclinedPermission];
        return @{@"title":@"Facebook 授權不完整", @"msg":msg};
    }
    
    return nil;
}

@end
