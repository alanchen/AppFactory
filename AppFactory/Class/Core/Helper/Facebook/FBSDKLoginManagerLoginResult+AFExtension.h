//
//  FBSDKLoginManagerLoginResult+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FBSDKLoginManagerLoginResult(AFExtension)

-(BOOL)isDeclinedPermissions;

-(NSDictionary *)declinedErrorWithREADPermission:(NSArray *)permission;

@end
