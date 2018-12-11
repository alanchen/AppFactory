//
//  AFRadioButton.h
//  AppFactory
//
//  Created by alan on 2017/10/24.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFRadioButton : UIButton

+(id)button;

-(void)setOnImageName:(NSString *)onImageName offImageName:(NSString *)offImageName;

-(void)setOnImage:(UIImage *)onImage offImage:(UIImage *)offImage;

-(void)setOnTitle:(NSString *)onTitle offTitle:(NSString *)offTitle;

-(void)setOnTitleColor:(UIColor *)onColor offColor:(UIColor *)offColor;

-(void)setOnBgColor:(UIColor *)onColor offBgColor:(UIColor *)offColor;


@property (nonatomic) BOOL isON;

@property (nonatomic) BOOL isAutoToggle;

@end
