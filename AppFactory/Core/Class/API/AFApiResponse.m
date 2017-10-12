//
//  AFApiResponse.m
//  AppFactory
//
//  Created by alan on 2017/10/5.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFApiResponse.h"
#import "APICategories.h"
#import "UsefulDefinition.h"
#import "NSMutableDictionary+AFExtension.h"
#import "LogMacros.h"

@implementation AFApiResponse

+(AFApiResponse *)responseWithTask:(NSURLSessionDataTask *)task res:(id)res error:(NSError *)error
{
    AFApiResponse *apiObj = [[AFApiResponse alloc] init];
    apiObj.task = task;
    apiObj.error = error;
    apiObj.resObj = res;
    apiObj.taskError = [AFApiTaskError errorWithNSError:error];
    
    return apiObj;
}

-(void)logWithDetail:(BOOL)isDetail showTask:(BOOL)showTask
{
    NSURLSessionDataTask *task = self.task;
    NSURLRequest *req = task.originalRequest;

    NSError *err = self.error;
    NSString *url = [req.URL absoluteString];
    NSString *method = req.HTTPMethod;
    NSMutableDictionary *result = [@{@"api":[NSString stringWithFormat:@"%@ %@", method, url]} mutableCopy];
    
    if(isDetail){
        id res =  NULL_TEST(self.resObj, task.response);
        id params = [@{} mutableCopy];
        NSString *paramsStr = [[NSString alloc] initWithData:[req HTTPBody] encoding:NSUTF8StringEncoding];
        NSArray *paramArr = [paramsStr componentsSeparatedByString:@"&"];
        [paramArr enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *itemArr = [item componentsSeparatedByString:@"="];
            if([itemArr count]==2){
                NSString *k = itemArr[0], *v = itemArr[1];
                params[k] = v;
            }
        }];
        [result safelySetObject:params forKey:@"params"];
        [result safelySetObject:res forKey:@"response"];
    }

    if(showTask){
        [result safelySetObject:task forKey:@"Task"];
    }

    if(err){
        if(isDetail){
            [result safelySetObject:err forKey:@"Error"];
        }else if(err.localizedDescription){
            [result safelySetObject:err.localizedDescription forKey:@"Error"];
        }
    }

    DLog(@"%@",result);
}

@end
