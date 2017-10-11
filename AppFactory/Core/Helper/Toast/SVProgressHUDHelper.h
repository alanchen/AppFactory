//
//  SVProgressHUDHelper.h
//  AppFactory
//
//  Created by alan on 2017/10/11.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD/SVProgressHUD.h>

#define HUD_SHOW    [SVProgressHUDHelper show]
#define HUD_DISMISS [SVProgressHUD dismiss]

@interface SVProgressHUDHelper : NSObject

+(void)show;

@end
