//
//  AFGhostButton.h
//  AppFactory
//
//  Created by alan on 2017/10/24.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFGhostButton : UIButton

+(AFGhostButton *)ghostButtonWithColor:(UIColor *)color font:(UIFont *)font;

-(void)setNormalColor:(UIColor *)normalColor;

@end
