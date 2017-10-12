//
//  AFApiResponse.h
//  AppFactory
//
//  Created by alan on 2017/10/5.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFApiTaskError.h"

@interface AFApiResponse : NSObject

@property (nonatomic,strong) NSURLSessionDataTask *task;
@property (nonatomic,strong) id resObj;
@property (nonatomic,strong) NSError *error;
@property (nonatomic,strong) AFApiTaskError *taskError;

+(AFApiResponse *)responseWithTask:(NSURLSessionDataTask *)op res:(id)res error:(NSError *)error;

-(void)logWithDetail:(BOOL)isDetail showTask:(BOOL)showTask;

@end
