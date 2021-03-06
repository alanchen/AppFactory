//
//  UITabBarController+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/9.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITabBarController(AFExtension)

-(void)switchToSelectedIndex:(NSUInteger)selectedIndex popToRootWithCompletion:(void (^)(void))completion;

-(UITabBarItem *)createTabBarItem:(NSString *)title
                        imageName:(NSString *)name
                textSelectedColor:(UIColor *)textSelectedColor;

// Try to fix the bug : After presentViewController, barItems are overlapped.
// I hope one day Apple will fix this problem.

-(void)addIPhoneXTabBarIfNeed;

@end
