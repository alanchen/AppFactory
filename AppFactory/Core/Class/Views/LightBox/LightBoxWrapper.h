//
//  LightBoxWrapper.h
//  PigMarket
//
//  Created by alan on 2017/2/7.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "LightBoxData.h"
#import "AppFactory.h"

#define LightboxShowAlignment(view,from,x,y) [[LightBoxWrapper sharedInstance] showContentView:view fromView:from horizontalAlign:x verticalAlign:y]
#define LightboxShowFrom(view,from) [[LightBoxWrapper sharedInstance] showContentView:view fromView:from]
#define LightboxShow(view) [[LightBoxWrapper sharedInstance] showContentView:view fromView:nil]

#define LightboxUpdateLayout [[LightBoxWrapper sharedInstance] updateLayout]
#define LightboxDismiss [[LightBoxWrapper sharedInstance] dismiss]

@interface LightBoxWrapper : UIView

@property (nonatomic)BOOL shouldTapBackbgroundToDismiss; // change it after show method

@property (nonatomic)CGFloat bgAlpha; 

+ (LightBoxWrapper *)sharedInstance;

- (void)showContentView:(UIView *)contentView
               fromView:(UIView *)fromView
        horizontalAlign:(LightBoxAlign)h
          verticalAlign:(LightBoxAlign)v;

- (void)showContentView:(UIView *)contentView
               fromView:(UIView *)fromView;

- (void)updateLayout;

- (void)dismiss;

- (void)dismissWithoutAnimation;

@end
