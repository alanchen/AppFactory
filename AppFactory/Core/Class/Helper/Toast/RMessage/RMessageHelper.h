//
//  RMessageHelper.h
//  PigMarket
//
//  Created by alan on 2017/3/14.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RMessage/RMessage.h>

@interface RMessageHelper : NSObject

+(void)setViewController:(UIViewController *)defaultViewController;

+(void)showError:(NSString *)title;

+(void)showWarning:(NSString *)title;

+(void)showOkay:(NSString *)title;

+(void)showMessage:(NSString *)title;

+(void)dismiss;

@end
