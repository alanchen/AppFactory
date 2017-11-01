//
//  AFButtonsView.h
//  AppFactory
//
//  Created by alan on 2017/11/1.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFGhostButton.h"

@interface AFButtonsView : UIView

@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) UIButton *centerBtn;

@property (nonatomic) CGFloat horizontalSpace; // Default is 15
@property (nonatomic) CGFloat customViewHeight; // Default is 80
@property (nonatomic) CGFloat customButtonWidth; // Default is 0. Calculating itself.
@property (nonatomic) CGFloat customButtonHeight; // Default is 50.

@property (nonatomic,strong) NSArray *buttons;

// Only support 2 type of array.
// Only center button , pass 1 item array.
// Left and right buttons , pass 2 items array.

+ (AFButtonsView *)viewWithButtons:(NSArray *)buttons;
+ (AFButtonsView *)viewWithButtons:(NSArray *)buttons buttonHeight:(CGFloat)buttonHeight;

+ (AFButtonsView *)viewWithButton:(UIButton *)btn;
+ (AFButtonsView *)viewWithButton:(UIButton *)btn buttonSize:(CGSize)size;

+ (UIButton *)createButtonWithFillledColor:(UIColor *)color
                                    title:(NSString *)title
                                     font:(UIFont *)font
                                   target:(id)target
                                   action:(SEL)action;

+ (AFGhostButton *)createGhostButtonWithColor:(UIColor *)color
                                        title:(NSString *)title
                                         font:(UIFont *)font
                                       target:(id)target
                                       action:(SEL)action;

@end
