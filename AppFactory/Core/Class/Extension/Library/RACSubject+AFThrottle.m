//
//  RACSubject+AFThrottle.m
//  AppFactory
//
//  Created by alan on 2017/10/25.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "RACSubject+AFThrottle.h"

@implementation RACSubject(AFThrottle)

+(RACSubject *)subjectWithThrottle:(NSTimeInterval)t block:(void (^)(void))block
{
    RACSubject *signal = [RACSubject subject];
    [[signal throttle:t] subscribeNext:^(id x) {
        if(block) block();
    }];
    
    return signal;
}

-(void)startThrottle
{
    [self sendNext:@"LaunchThrottle"];
}

@end
