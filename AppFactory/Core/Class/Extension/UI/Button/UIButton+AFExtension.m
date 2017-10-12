//
//  UIButton+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIButton+AFExtension.h"
#import "LibsHeader.h"

@implementation UIButton(AFExtension)

-(void)setGap:(CGFloat)gap
{
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -gap / 2, 0, gap / 2);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, gap / 2, 0 , - gap / 2);
    self.contentEdgeInsets = UIEdgeInsetsMake(0, gap / 2, 0, gap / 2);
}

-(void)setNormalImage:(UIImage *)img
{
    if(!img) return;
    [self setImage:img forState:UIControlStateNormal];
}

-(void)setNormalImageName:(NSString *)imgName
{
    if(!imgName) return;
    [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
}

-(void)setNormalTitle:(NSString *)text
{
    [self setTitle:text forState:UIControlStateNormal];
}

-(void)setNormalTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}

-(void)setTitleFont:(UIFont *)font
{
    self.titleLabel.font = font;
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state
{
    UIImage *img = [UIImage imageWithColor:color];
    [self setBackgroundImage:img forState:state];
}

-(void)addNormalTarget:(id)target action:(SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)bk_addNormalEventHandler:(void (^)(id sender))handler
{
    [self bk_addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
}

- (void)addHighlightAlphaEffect
{
    __weak __typeof(self) weakSelf = self;
    weakSelf.adjustsImageWhenHighlighted = NO;

    [self bk_addEventHandler:^(UIView *sender) {
        weakSelf.alpha = 0.5;
    } forControlEvents:UIControlEventTouchDown];

    [self bk_addEventHandler:^(UIView *sender) {
        weakSelf.alpha = 1.0;
    } forControlEvents:UIControlEventTouchUpInside];

    [self bk_addEventHandler:^(UIView *sender) {
        weakSelf.alpha = 1.0;
    } forControlEvents:UIControlEventTouchUpOutside];

    [self bk_addEventHandler:^(UIView *sender) {
        weakSelf.alpha = 1.0;
    } forControlEvents:UIControlEventTouchCancel];

    [self bk_addEventHandler:^(UIView *sender) {
        weakSelf.alpha = 1.0;
    } forControlEvents:UIControlEventTouchDragOutside];
}

@end
