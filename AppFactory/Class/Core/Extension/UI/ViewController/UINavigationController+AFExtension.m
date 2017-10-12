//
//  UINavigationController+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UINavigationController+AFExtension.h"
#import "LibsHeader.h"

@interface UINavigationController(StatusBarStyle)
@property (nonatomic,strong) NSNumber *typeNumber;
@end

@implementation UINavigationController(StatusBarStyle)
SYNTHESIZE_ASC_OBJ(typeNumber, setTypeNumber);
@end

@implementation UINavigationController(AFExtension)

-(void)setNavigationBarColor:(UIColor *)color
{
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:color]
                             forBarMetrics:UIBarMetricsDefault];
}

-(void)setNavigationBarTitleTextColor:(UIColor *)color
{
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName,nil]];
}

-(void)setNavigationBarTintColor:(UIColor *)color
{
    self.navigationBar.tintColor = color;
}

-(NavigationBarStyle)barStyle{
    if(!self.typeNumber){
        [self setBarStyle:NavigationBarStyleLight];
    }
    
    return [self.typeNumber integerValue];
}

-(void)setBarStyle:(NavigationBarStyle)barStyle{
    self.typeNumber = @(barStyle);
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    if(self.barStyle == NavigationBarStyleLight){
        return UIStatusBarStyleDefault;
    }
    
    return UIStatusBarStyleLightContent;
}

-(UIViewController *)rootViewController
{
    return [[self viewControllers] firstObject];
}

-(NSInteger)viewControllersCount
{
    return [[self viewControllers] count];
}

-(BOOL) isContainVC:(id)vc
{
    return [self.viewControllers containsObject:vc];
}

-(UIViewController *)findVCOfClass:(Class)class
{
    id theVC = [self.viewControllers bk_match:^BOOL(id vc) {
        if([vc isKindOfClass:class]){
            return YES;
        }
        return NO;
    }];
    
    return theVC;
}

@end
