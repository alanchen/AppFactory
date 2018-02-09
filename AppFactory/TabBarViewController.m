//
//  TabBarViewController.m
//  AppFactory
//
//  Created by alan on 2018/2/7.
//  Copyright © 2018年 alan. All rights reserved.
//

#import "TabBarViewController.h"
#import "ViewController.h"
#import "AFBaseNavigationController.h"
#import "UITabBarController+AFExtension.h"


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addIPhoneXTabBarIfNeed];
    
    ViewController *vc1 = [[ViewController alloc] init];
    AFBaseNavigationController *navi1 =[AFBaseNavigationController navigationWithRootViewController:vc1];
    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil selectedImage:nil];
    navi1.tabBarItem = tabBarItem1;
    
    ViewController *vc2 = [[ViewController alloc] init];
    AFBaseNavigationController *navi2 =[AFBaseNavigationController navigationWithRootViewController:vc2];
    UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil selectedImage:nil];
    navi2.tabBarItem = tabBarItem2;
    
    self.viewControllers = @[navi1,navi2];
    self.selectedIndex = 0;
}


@end
