//
//  SVProgressHUDHelper.m
//  AppFactory
//
//  Created by alan on 2017/10/11.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "SVProgressHUDHelper.h"

@implementation SVProgressHUDHelper

+(void)show
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
}

@end
