//
//  AFNaviBar.m
//  AppFactory
//
//  Created by alan on 2017/11/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFNaviBar.h"
#import <ViewUtils/ViewUtils.h>
#import "UIButton+AFExtension.h"
#import "UIButton+ExpandHitArea.h"
#import "UIView+AFExtension.h"

@implementation AFNaviBar

+(AFNaviBar *)view
{
    AFNaviBar *v = [[AFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    return v;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.titleLabel];
        
        self.leftPadding = 15;
        self.rightPadding = 15;
        
        self.rightBtnSize = CGSizeMake(24, 24);
        self.leftBtnSize = CGSizeMake(24, 24);
    }

    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.leftButton.size = self.leftBtnSize;
    self.leftButton.left = self.leftPadding;
    self.leftButton.centerY = self.height/2;
    
    self.rightButton.size = self.rightBtnSize;
    self.rightButton.right = self.width - self.rightPadding;
    self.rightButton.centerY = self.height/2;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.centerY = self.height/2;
    self.titleLabel.centerX = self.width/2;
}

-(UIButton *)leftButton
{
    if(!_leftButton){
        _leftButton = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addHighlightAlphaEffect];
            [btn setExtend20TappingArea];
 
            btn.hidden = YES;
            btn;
        });
    }
    
    return _leftButton;
}

-(UIButton *)rightButton
{
    if(!_rightButton){
        _rightButton = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addHighlightAlphaEffect];
            [btn setExtend20TappingArea];
            btn.hidden = YES;
            btn;
        });
    }
    
    return _rightButton;
}

-(UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return _titleLabel;
}

@end
