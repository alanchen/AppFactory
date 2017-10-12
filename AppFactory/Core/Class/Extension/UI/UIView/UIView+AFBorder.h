//
//  UIView+AFBorder.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ViewBorderWidth(w) (w / [UIScreen mainScreen].scale)
#define kViewBorderWidth1px ViewBorderWidth(1.0)

@interface UIView(AFBorder)

-(void)showTopBorderWithColor:(UIColor *)color;
-(void)showTopBorderWithColor:(UIColor *)color padding:(float)padding;

-(void)showBottomBorderWithColor:(UIColor *)color;
-(void)showBottomBorderWithColor:(UIColor *)color padding:(float)padding;

-(void)showLeftBorderWithColor:(UIColor *)color;
-(void)showLeftBorderWithColor:(UIColor *)color padding:(float)padding;

-(void)showRightBorderWithColor:(UIColor *)color;
-(void)showRightBorderWithColor:(UIColor *)color padding:(float)padding;

- (void)setCornerRadius:(CGFloat)cornerRadius
            borderColor:(UIColor *)color
            borderWidth:(CGFloat)width;

@end
