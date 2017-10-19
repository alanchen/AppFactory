//
//  FBSSOResult.h
//  AppFactory
//
//  Created by alan on 2017/10/19.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface FBSSOResult : NSObject

@property (nonatomic) id userData;
@property (nonatomic) FBSDKLoginManagerLoginResult *sdkResult;
@property (nonatomic) NSError *error;

+(FBSSOResult *)resultWith:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error;
-(BOOL)isCancelled;
-(BOOL)isSuccess;

@end
