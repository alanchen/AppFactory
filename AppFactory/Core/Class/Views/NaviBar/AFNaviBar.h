//
//  AFNaviBar.h
//  AppFactory
//
//  Created by alan on 2017/11/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFNaviBar : UIView

+(AFNaviBar *)view;

@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic) CGFloat leftPadding; // Default is 15
@property (nonatomic) CGFloat rightPadding; // Default is 15

@property (nonatomic) CGSize leftBtnSize; // Default is  CGSizeMake(24, 24)
@property (nonatomic) CGSize rightBtnSize; // Default is  CGSizeMake(24, 24)

@end
