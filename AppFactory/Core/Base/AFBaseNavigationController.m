//
//  AFBaseNavigationController.m
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFBaseNavigationController.h"

@interface AFBaseNavigationController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation AFBaseNavigationController

+(AFBaseNavigationController *)navigationWithRootViewController:(UIViewController *)rootViewController
{
    return [[AFBaseNavigationController alloc] initWithRootViewController:rootViewController];
}

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if(self){
        __weak __typeof(self)weakSelf = self;
        self.interactivePopGestureRecognizer.enabled = YES;
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate  = weakSelf;
    }
    
    return self;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers.firstObject){
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
            self.interactivePopGestureRecognizer.enabled = NO;
    }else{
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
            self.interactivePopGestureRecognizer.enabled = YES;
        
        if(viewController.navigationController.navigationBarHidden){
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

@end
