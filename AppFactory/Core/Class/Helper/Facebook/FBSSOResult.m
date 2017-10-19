//
//  FBSSOResult.m
//  AppFactory
//
//  Created by alan on 2017/10/19.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "FBSSOResult.h"

@implementation FBSSOResult

+(FBSSOResult *)resultWith:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    FBSSOResult *obj = [[FBSSOResult alloc] init];
    obj.sdkResult = result;
    obj.error = error;
    
    return  obj;
}

-(BOOL)isCancelled
{
    return YES;
}

-(BOOL)isSuccess
{
    if(self.error)
        return NO;
    
    if(self.sdkResult.isCancelled || [self.sdkResult.declinedPermissions count])
        return NO;
    
    if(self.userData)
        return YES;
    
     return NO;
}

@end

