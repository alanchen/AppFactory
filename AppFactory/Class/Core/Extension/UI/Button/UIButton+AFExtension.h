//
//  UIButton+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIButton+ExpandHitArea.h"

@interface UIButton(AFExtension)

-(void)setGap:(CGFloat)gap;

-(void)setNormalImage:(UIImage *)img;

-(void)setNormalImageName:(NSString *)imgName;

-(void)setNormalTitle:(NSString *)text;

-(void)setNormalTitleColor:(UIColor *)color;

-(void)setTitleFont:(UIFont *)font;

-(void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

-(void)addNormalTarget:(id)target action:(SEL)action;

-(void)bk_addNormalEventHandler:(void (^)(id sender))handler;

-(void)addHighlightAlphaEffect;

@end
