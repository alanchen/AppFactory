//
//  UIApplication+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/9.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIApplication+AFExtension.h"

@implementation UIApplication(AFExtension)

-(UIViewController *)visibleViewController
{
    UIViewController *rootViewController = self.keyWindow ? self.keyWindow.rootViewController:nil;
    return [self getVisibleViewController:rootViewController];
}

-(UIViewController *)getVisibleViewController:(UIViewController *)rootViewController
{
    UIViewController *presentedViewController = rootViewController.presentedViewController;
    if(presentedViewController){
        return [self getVisibleViewController:presentedViewController];
    }
    
    if([rootViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *navigationController = (UINavigationController *) rootViewController;
        return navigationController.visibleViewController;
    }
    
    if([rootViewController isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabBarController = (UITabBarController *) rootViewController;
        return [self getVisibleViewController:tabBarController.selectedViewController];
    }
    
    return rootViewController;
}

-(BOOL)isAppActive
{
    return self.applicationState == UIApplicationStateActive;
}

@end
