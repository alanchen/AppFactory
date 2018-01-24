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

-(void)switchToSelectedIndex:(NSUInteger)selectedIndex popToRootWithCompletion:(void (^)(void))completion
{
    if(self.selectedIndex == selectedIndex){
        [self setSelectedIndex:selectedIndex];
        [self popViewcontroller:self.selectedViewController toRootWithAnimation:NO];
        if(completion){ completion (); }
        return;
    }

    UIViewController *topVC = (UIViewController *)((UINavigationController *)self.selectedViewController).topViewController;
    if(topVC.presentedViewController){
        [topVC dismissViewControllerAnimated:NO completion:^{
            [self popViewcontroller:topVC toRootWithAnimation:NO];
            [self setSelectedIndex:selectedIndex];
            if(completion){ completion (); }
        }];
    }else{
        [self popViewcontroller:topVC toRootWithAnimation:NO];
        [self setSelectedIndex:selectedIndex];
        if(completion){ completion (); }
    }
}

#pragma mark - Private

-(void)popViewcontroller:(UIViewController *)vc toRootWithAnimation:(BOOL)animated
{
    if([vc isKindOfClass:[UINavigationController class]]){
        [(UINavigationController *)vc popToRootViewControllerAnimated:animated];
        return;
    }
    
    [vc.navigationController popToRootViewControllerAnimated:animated];
}

@end
