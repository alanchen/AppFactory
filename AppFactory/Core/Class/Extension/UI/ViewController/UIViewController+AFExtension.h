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

#pragma mark -

-(void)setLeftBarButtonItem:(UIBarButtonItem *)item;

-(void)setRightBarButtonItem:(UIBarButtonItem *)item;

- (UIBarButtonItem *)setRightBarItemWithButtonImageName:(NSString *)name
                                                 target:(id)target
                                                 action:(SEL)action;

- (UIBarButtonItem *)setRightBarItemWithTitle:(NSString *)title
                                       target:(id)target
                                       action:(SEL)action;

- (UIBarButtonItem *)setLeftBarItemWithTitle:(NSString *)title
                                      target:(id)target
                                      action:(SEL)action;

- (UIBarButtonItem *)setLeftBarItemWithButtonImageName:(NSString *)name
                                                target:(id)target
                                                action:(SEL)action;

@end
