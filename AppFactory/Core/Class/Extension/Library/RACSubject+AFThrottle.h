//
//  RACSubject+AFThrottle.h
//  AppFactory
//
//  Created by alan on 2017/10/25.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSubject(AFThrottle)

+(RACSubject *)subjectWithThrottle:(NSTimeInterval)t block:(void (^)(void))block;

-(void)startThrottle;

@end
