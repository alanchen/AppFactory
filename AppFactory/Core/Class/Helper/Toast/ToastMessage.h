//
//  ToastMessage.h
//  AppFactory
//
//  Created by alan on 2017/10/6.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

#define ToastShow(str) [ToastMessage show:str]
#define ToastShowWithSound(str) [ToastMessage showWithSound:str]

@interface ToastMessage : NSObject
+(void)setBottomOffsetPortrait:(float)offset; // default is 90
+(void)show:(NSString *)str;
+(void)show:(NSString *)str window:(UIWindow *)window;
+(void)showWithSound:(NSString *)str;

@end
