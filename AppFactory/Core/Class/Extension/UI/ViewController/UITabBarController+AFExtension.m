//
//  UITabBarController+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/9.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UITabBarController+AFExtension.h"
#import "UIViewController+AFExtension.h"
#import "AFBaseTabBar.h"
#import "DeviceMacros.h"

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

-(UITabBarItem *)createTabBarItem:(NSString *)title
                        imageName:(NSString *)name
                textSelectedColor:(UIColor *)textSelectedColor
{
    //    About 50 x 50 pixels (96 x 64 pixels maximum)
    //    About 25 x 25 pixels (48 x 32 pixels maximum) for standard resolution
    
    UIImage *img = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:img selectedImage:img];
    if(textSelectedColor){
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:textSelectedColor}
                                  forState:UIControlStateSelected];
    }
    return tabBarItem;
}

-(void)addIPhoneXTabBarIfNeed
{
    if (IS_IPHONE_X) {
        AFBaseTabBar *baseTabBar = [[AFBaseTabBar alloc] init];
        [self setValue:baseTabBar forKey:@"tabBar"];
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
