//
//  APNModel.m
//  AppFactory
//
//  Created by alan on 2017/10/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "APNModel.h"
#import "NSObject+AFExtension.h"

@implementation APNModel

+(id)modelWithNotification:(NSDictionary *)userInfo
{
    id obj = [[[self class] alloc] initWithInfo:userInfo];
    return obj;
}

- (id)initWithInfo:(id)info
{
    self = [super init];
    
    if (self){
        self.userInfo = info;
        self.aps    = [self.userInfo safelyObjectForKey:@"aps"];
        self.alert  = [self.aps safelyObjectForKey:@"alert"];
        self.sound  = [self.aps safelyObjectForKey:@"sound"];
        self.badge  = [self.aps safelyIntegerForKey:@"badge"];
        self.payload = [self.userInfo safelyObjectForKey:@"payload"];
    }
    
    return self;
}

@end
