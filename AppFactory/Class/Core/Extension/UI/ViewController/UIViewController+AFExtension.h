//
//  UIViewController+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController(AFExtension)

-(UIViewController *)topMostViewController;

-(BOOL)isRootViewController;

-(CGFloat)defaultNavigationbarHeight;

-(CGFloat)navigationbarHeight;

- (void)popToRootIfItCanWithAnimated:(BOOL)animated;

@end
