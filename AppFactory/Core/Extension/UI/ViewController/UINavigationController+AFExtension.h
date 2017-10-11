//
//  UINavigationController+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NavigationBarStyle){
    NavigationBarStyleLight,
    NavigationBarStyleDark
};

@interface UINavigationController(AFExtension)

-(void)setNavigationBarColor:(UIColor *)color;
-(void)setNavigationBarTitleTextColor:(UIColor *)color;
-(void)setNavigationBarTintColor:(UIColor *)color;

@property (nonatomic) NavigationBarStyle barStyle;

-(UIViewController *)rootViewController;
-(NSInteger)viewControllersCount;
-(BOOL)isContainVC:(id)vc;
-(UIViewController *)findVCOfClass:(Class)class;


@end
