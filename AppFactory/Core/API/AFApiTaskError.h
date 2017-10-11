//
//  AFApiTaskError.h
//  AppFactory
//
//  Created by alan on 2017/10/5.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, AFApiTaskErrorType){
    AFApiTaskErrorTypeUndefined,
    AFApiTaskErrorTypeUnknown,
    AFApiTaskErrorTypeOffline,
    AFApiTaskErrorTypeTimeout,
    AFApiTaskErrorTypeCancel
};

@interface AFApiTaskError : NSObject

@property (nonatomic,strong) NSError *error;

+(AFApiTaskError *)errorWithNSError:(NSError *)error;

-(AFApiTaskErrorType)type;

-(NSString *)errorText;

@end
