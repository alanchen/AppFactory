//
//  UIView+AFBorder.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIView+AFBorder.h"
#import "LibsHeader.h"

@implementation UIView(AFBorder)

-(void)showTopBorderWithColor:(UIColor *)color
{
    UIView *border = [[UIView alloc] initWithFrame:CGRectZero];
    border.backgroundColor = color;
    [self addSubview:border];
    
    @weakify(self);
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(self);
        make.height.equalTo(@(kViewBorderWidth1px));
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
}

-(void)showTopBorderWithColor:(UIColor *)color padding:(float)padding
{
    UIView *border = [[UIView alloc] initWithFrame:CGRectZero];
    border.backgroundColor = color;
    [self addSubview:border];
    
    @weakify(self);
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(self).with.offset(-padding*2);
        make.height.equalTo(@(kViewBorderWidth1px));
        make.top.equalTo(@0);
        make.left.equalTo(@(padding));
    }];
}

-(void)showBottomBorderWithColor:(UIColor *)color
{
    UIView *border = [[UIView alloc] initWithFrame:CGRectZero];
    border.backgroundColor = color;
    [self addSubview:border];
    
    @weakify(self);
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(self);
        make.height.equalTo(@(kViewBorderWidth1px));
        make.bottom.equalTo(self);
        make.left.equalTo(@0);
    }];
}

-(void)showBottomBorderWithColor:(UIColor *)color padding:(float)padding
{
    UIView *border = [[UIView alloc] initWithFrame:CGRectZero];
    border.backgroundColor = color;
    [self addSubview:border];
    
    @weakify(self);
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(self).with.offset(-padding*2);
        make.height.equalTo(@(kViewBorderWidth1px));
        make.bottom.equalTo(self);
        make.left.equalTo(@(padding));
    }];
}

-(void)showLeftBorderWithColor:(UIColor *)color
{
    UIView *border = [[UIView alloc] initWithFrame:CGRectZero];
    border.backgroundColor = color;
    [self addSubview:border];
    
    @weakify(self);
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(@(kViewBorderWidth1px));
        make.height.equalTo(self);
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
}

-(void)showLeftBorderWithColor:(UIColor *)color padding:(float)padding
{
    UIView *border = [[UIView alloc] initWithFrame:CGRectZero];
    border.backgroundColor = color;
    [self addSubview:border];
    
    @weakify(self);
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(@(kViewBorderWidth1px));
        make.height.equalTo(self).with.offset(-padding*2);
        make.top.equalTo(@(padding));
        make.left.equalTo(@0);
    }];
}

-(void)showRightBorderWithColor:(UIColor *)color
{
    UIView *border = [[UIView alloc] initWithFrame:CGRectZero];
    border.backgroundColor = color;
    [self addSubview:border];
    
    @weakify(self);
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(@(kViewBorderWidth1px));
        make.height.equalTo(self);
        make.top.equalTo(@0);
        make.right.equalTo(self);
    }];
}

-(void)showRightBorderWithColor:(UIColor *)color padding:(float)padding
{
    UIView *border = [[UIView alloc] initWithFrame:CGRectZero];
    border.backgroundColor = color;
    [self addSubview:border];
    
    @weakify(self);
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(@(kViewBorderWidth1px));
        make.height.equalTo(self).with.offset(-padding*2);
        make.top.equalTo(@(padding));
        make.right.equalTo(self);
    }];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
            borderColor:(UIColor *)color
            borderWidth:(CGFloat)width
{
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
    if(color){ self.layer.borderColor = color.CGColor;}
    if(width){ self.layer.borderWidth = width;}
}

@end
