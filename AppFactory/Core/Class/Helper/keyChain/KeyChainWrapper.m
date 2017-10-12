//
//  KeyChainWrapper.m
//  FreePoint
//
//  Created by alan on 2015/6/2.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "KeyChainWrapper.h"
@import SAMKeychain;

static NSString *kServiceName = @"com.userid.www";
static NSString *kAccount = @"idfv";

@implementation KeyChainWrapper

+ (NSString *) deviceId
{
    NSString *device_id = [SAMKeychain passwordForService:kServiceName account:kAccount];
    return [device_id length]?device_id:@"";
}

+ (BOOL) saveDeviceId:(NSString *)deviceId
{
    if(![deviceId length])
        return NO;
    
    return [SAMKeychain setPassword:deviceId forService:kServiceName account:kAccount];
}

+ (BOOL) deleteDeviceId
{
    return [SAMKeychain deletePasswordForService:kServiceName account:kAccount];
}

@end
