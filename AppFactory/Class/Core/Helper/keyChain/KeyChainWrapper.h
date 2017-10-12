//
//  KeyChainWrapper.h
//  FreePoint
//
//  Created by alan on 2015/6/2.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainWrapper : NSObject

+ (NSString *) deviceId;
+ (BOOL) saveDeviceId:(NSString *)deviceId;
+ (BOOL) deleteDeviceId;

@end
