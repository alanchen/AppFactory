//
//  AFRadioButton.m
//  AppFactory
//
//  Created by alan on 2017/10/24.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFRadioButton.h"
#import "UIButton+AFExtension.h"

@interface AFRadioButton ()

@property (nonatomic,strong) NSString *onImageName;
@property (nonatomic,strong) NSString *offImageName;

@property (nonatomic,strong) UIImage *onImage;
@property (nonatomic,strong) UIImage *offImage;

@property (nonatomic,strong) NSString *onTitle;
@property (nonatomic,strong) NSString *offTitle;

@property (nonatomic,strong) UIColor *onTitleColor;
@property (nonatomic,strong) UIColor *offTitleColor;

@property (nonatomic,strong) UIColor *onBgColor;
@property (nonatomic,strong) UIColor *offBgColor;

@property (nonatomic,strong) UIColor *onBorderColor;
@property (nonatomic,strong) UIColor *offBorderColor;

@property (nonatomic,copy) void (^disableStyleBlock)(id obj);

@end

@implementation AFRadioButton

+(id)button
{
    AFRadioButton *btn = [[self class] buttonWithType:UIButtonTypeCustom];
    [btn setExtendTappingAreaInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [btn setAdjustsImageWhenHighlighted:NO];
    btn.isAutoToggle = YES;
    
    return btn;
}

-(void)setOnImageName:(NSString *)onImageName offImageName:(NSString *)offImageName
{
    if(onImageName){
        self.onImageName = onImageName;
    }
    
    if(offImageName){
        self.offImageName = offImageName;
    }
    
    [self updateLayout];
}

-(void)setOnImage:(UIImage *)onImage offImage:(UIImage *)offImage
{
    if(onImage){
        self.onImage = onImage;
    }
    
    if(offImage){
        self.offImage = offImage;
    }
    
    [self updateLayout];
}

-(void)setOnTitle:(NSString *)onTitle offTitle:(NSString *)offTitle
{
    if(onTitle){
        self.onTitle = onTitle;
    }
    
    if(offTitle){
        self.offTitle = offTitle;
    }
    
    [self updateLayout];
}

-(void)setOnTitleColor:(UIColor *)onColor offColor:(UIColor *)offColor
{
    if(onColor){
        self.onTitleColor = onColor;
    }
    
    if(offColor){
        self.offTitleColor = offColor;
    }
    
    [self updateLayout];
}

-(void)setOnBorderColor:(UIColor *)onColor offBorderColor:(UIColor *)offColor
{
    if(onColor){
        self.onBorderColor = onColor;
    }
    
    if(offColor){
        self.offBorderColor = offColor;
    }
    
    [self updateLayout];
}

-(void)setOnBgColor:(UIColor *)onColor offBgColor:(UIColor *)offColor
{
    if(onColor){
        self.onBgColor = onColor;
    }
    
    if(offColor){
        self.offBgColor = offColor;
    }
    
    [self updateLayout];
}

-(void)setDisableStyle:(void (^)(AFRadioButton *btn))block
{
    self.disableStyleBlock = block;
}

-(void)setIsON:(BOOL)isON
{
    _isON  = isON;
    [self updateLayout];
}

-(void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self updateLayout];
}

-(void)setIsAutoToggle:(BOOL)isAutoToggle
{
    _isAutoToggle = isAutoToggle;
    [self addTarget:self action:@selector(buttonToggle:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonToggle:(id)sender
{
    if(!self.isAutoToggle)
        return;
    
    self.isON = !self.isON;
}

-(void)updateLayout
{
    if( !self.enabled && self.disableStyleBlock) {
        self.disableStyleBlock(self);
        return;
    }
    
    if(_isON){
        if(self.onImageName){
            [self setImage:[UIImage imageNamed:self.onImageName] forState:UIControlStateNormal];
        }else if(self.onImage){
            [self setImage:self.onImage forState:UIControlStateNormal];
        }
        
        if(self.onTitle){
            [self setTitle:self.onTitle forState:UIControlStateNormal];
        }
        
        if(self.onTitleColor){
            [self setTitleColor:self.onTitleColor forState:UIControlStateNormal];
        }
        
        if(self.onBgColor){
            [self setBackgroundColor:self.onBgColor forState:UIControlStateNormal];
        }
        
        if(self.onBorderColor){
            self.layer.borderColor = self.onBorderColor.CGColor;
        }
    }else{
        if(self.offImageName){
            [self setImage:[UIImage imageNamed:self.offImageName] forState:UIControlStateNormal];
        }else if(self.offImage){
            [self setImage:self.offImage forState:UIControlStateNormal];
        }
        
        if(self.offTitle){
            [self setTitle:self.offTitle forState:UIControlStateNormal];
        }
        
        if(self.offTitleColor){
            [self setTitleColor:self.offTitleColor forState:UIControlStateNormal];
        }
        
        if(self.offBgColor){
            [self setBackgroundColor:self.offBgColor forState:UIControlStateNormal];
        }
        
        if(self.offBorderColor){
            self.layer.borderColor = self.offBorderColor.CGColor;
        }
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


@end
