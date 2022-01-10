//
//  AFGhostButton.m
//  AppFactory
//
//  Created by alan on 2017/10/24.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFGhostButton.h"
#import "UIImage-Helpers.h"
#import "UIColor+AFExtension.h"

@interface AFGhostButton ()

@property (nonatomic,strong)UIColor *normalColor;
@property (nonatomic,strong)UIColor *disableColor;

@end

@implementation AFGhostButton

+(AFGhostButton *)ghostButtonWithColor:(UIColor *)color font:(UIFont *)font
{
    AFGhostButton *btn = [[self class] buttonWithType:UIButtonTypeCustom];
    btn.normalColor = color;
    btn.titleLabel.font = font;
    
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [btn setClipsToBounds:YES];
    btn.layer.cornerRadius = 4.0;
    btn.layer.borderWidth = 1.0;
    
    return  btn;
}

-(void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    [self setBackgroundImage:[UIImage imageWithColor:normalColor] forState:UIControlStateHighlighted];
    [self setTitleColor:normalColor forState:UIControlStateNormal];

    if(self.enabled){
        self.layer.borderColor = normalColor.CGColor;
    }
    
    self.disableColor = normalColor.withAlpha(0.4);
}

-(void)setDisableColor:(UIColor *)disableColor
{
    _disableColor = disableColor;
    [self setTitleColor:disableColor forState:UIControlStateDisabled];

    if(!self.enabled){
        self.layer.borderColor = disableColor.CGColor;
    }
}

-(void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if (enabled){
        self.layer.borderColor = self.normalColor.CGColor;
    }else{
        self.layer.borderColor = self.disableColor.CGColor;
    }
}

@end
