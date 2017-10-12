//
//  AFApiTaskError.m
//  AppFactory
//
//  Created by alan on 2017/10/5.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFApiTaskError.h"

@implementation AFApiTaskError

+(AFApiTaskError *)errorWithNSError:(NSError *)error
{
    if(!error || ![error isKindOfClass:[NSError class]])
        return nil;
    
    AFApiTaskError *err = [[AFApiTaskError alloc] init];
    err.error = error;
    
    return  err;
}

-(AFApiTaskErrorType)type
{
    if(self.error){
        if(self.error.code == -999){
            return AFApiTaskErrorTypeCancel;
        }else if(self.error.code == -1009){
            return AFApiTaskErrorTypeOffline;
        }else if(self.error.code == -1001){
            return AFApiTaskErrorTypeTimeout;
        }else{
            return AFApiTaskErrorTypeUnknown;
            
        }
    }
    
    return AFApiTaskErrorTypeUndefined;
}

-(NSString *)errorText
{
    AFApiTaskErrorType type = [self type];
    
    switch (type) {
        case AFApiTaskErrorTypeOffline:
            return @"網路無法連線";
            break;
        case AFApiTaskErrorTypeTimeout:
            return @"網路連線逾時";
            break;
        case AFApiTaskErrorTypeUnknown:
            return @"系統暫時異常";
            break;
            
        default:
            break;
    }
    
    return nil;
}

@end
