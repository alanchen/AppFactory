//
//  UITextField+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITextField(AFExtension)

//-(void)setPlaceholderColor:(UIColor *)color;
//
//-(void)setPlaceholderFont:(UIFont *)font;

-(void)setPlaceholder:(NSString *)placeholderStr font:(UIFont *)font color:(UIColor *)color;

@end
