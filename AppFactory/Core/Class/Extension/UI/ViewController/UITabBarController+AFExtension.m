//
//  UITabBarController+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/9.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UITabBarController+AFExtension.h"
#import "UIViewController+AFExtension.h"

@implementation UITabBarController(AFExtension)

-(void)switchToSelectedIndex:(NSUInteger)selectedIndex popToRootWithCompletion:(void (^)())completion
{
    if(self.selectedIndex == selectedIndex){
        [self setSelectedIndex:selectedIndex];
        [self.selectedViewController popToRootIfItCanWithAnimated:NO];
        if(completion){ completion (); }
        return;
    }

    UIViewController *topVC = (UIViewController *)((UINavigationController *)self.selectedViewController).topViewController;
    if(topVC.presentedViewController){
        [topVC dismissViewControllerAnimated:NO completion:^{
            [topVC popToRootIfItCanWithAnimated:NO];
            [self setSelectedIndex:selectedIndex];
            if(completion){ completion (); }
        }];
    }else{
        [topVC popToRootIfItCanWithAnimated:NO];
        [self setSelectedIndex:selectedIndex];
        if(completion){ completion (); }
    }
}

@end
