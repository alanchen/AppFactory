//
//  UIBarButtonItem+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIBarButtonItem(AFExtension)

+(UIBarButtonItem *)barItemWithImgName:(NSString *)imgName
                                target:(id)target
                                action:(SEL)action;

-(void)setNormalTitleTextFont:(UIFont *)font textColor:(UIColor *)color;

-(void)setNormalTitleTextFont:(UIFont *)font;

-(void)setNormalTitleTextColor:(UIColor *)color;

-(void)setCustomViewSize:(CGSize)size;

@end
