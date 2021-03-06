//
//  UIViewController+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIViewController+AFExtension.h"
#import "UINavigationController+AFExtension.h"
#import "LibsHeader.h"
#import "UIComponentFactory.h"
#import "UIButton+AFExtension.h"

@implementation UIViewController(AFExtension)

#pragma mark - Public

-(UIViewController *)topMostViewController
{
    // Combine both topPresentedViewController and topVisibleViewController methods,
    // to get top visible viewcontroller in top present level
    
    return  self.topPresentedViewController.topVisibleViewController;
}

-(BOOL)isRootViewController
{
    if([self.navigationController rootViewController] == self)
        return YES;
    
    return NO;
}

-(CGFloat)defaultNavigationbarHeight
{
    return 44.0;
}

-(CGFloat)navigationbarHeight
{
    CGFloat naviH = self.navigationController.navigationBar.height;
    return naviH?naviH:44;
}

#pragma mark -

-(void)setLeftBarButtonItem:(UIBarButtonItem *)item
{
    self.navigationItem.leftBarButtonItem = item;
}

-(void)setRightBarButtonItem:(UIBarButtonItem *)item
{
    self.navigationItem.rightBarButtonItem = item;
}

- (UIBarButtonItem *)setLeftBarItemWithButtonImageName:(NSString *)name
                                                target:(id)target
                                                action:(SEL)action
{
    UIBarButtonItem *barItem = [UIComponentFactory barButtonItemWithCustomeViewImageName:name target:target action:action];
    [((UIButton *)barItem.customView) addHighlightAlphaEffect];
    [self setLeftBarButtonItem:barItem];
    return barItem;
}

- (UIBarButtonItem *)setRightBarItemWithButtonImageName:(NSString *)name
                                                 target:(id)target
                                                 action:(SEL)action
{
    UIBarButtonItem *barItem = [UIComponentFactory barButtonItemWithCustomeViewImageName:name target:target action:action];
    [((UIButton *)barItem.customView) addHighlightAlphaEffect];
    [self setRightBarButtonItem:barItem];
    return barItem;
}

- (UIBarButtonItem *)setLargeHitRightBarItemWithButtonImageName:(NSString *)name
                                                         target:(id)target
                                                         action:(SEL)action
{
    if(!name){name = @"";}
    
    UIImage *image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    UIView *view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, btn.width + 16, 38)];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:btn];
    [btn setExtend20TappingArea];
    [btn addHighlightAlphaEffect];
    btn.center = CGPointMake(view.width/2, view.height/2);
    btn.right = view.width;

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    [self setRightBarButtonItem:item];
    return item;
}

- (UIBarButtonItem *)setLeftBarItemWithTitle:(NSString *)title
                                      target:(id)target
                                      action:(SEL)action
{
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    [self setLeftBarButtonItem:barItem];
    return barItem;
}

- (UIBarButtonItem *)setRightBarItemWithTitle:(NSString *)title
                                      target:(id)target
                                      action:(SEL)action
{
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    [self setRightBarButtonItem:barItem];
    return barItem;
}

#pragma mark - Private

-(UIViewController *)topPresentedViewController
{
    // Get ViewController in top present level
    UIViewController *targetVC = self;
    while (targetVC.presentedViewController != nil) {
        targetVC = targetVC.presentedViewController;
    }
    return targetVC;
}

-(UIViewController *)topVisibleViewController
{
    // Get top VisibleViewController from ViewController stack in same present level.
    // It should be visibleViewController if self is a UINavigationController instance
    // It should be selectedViewController if self is a UITabBarController instance
    
    if([self isKindOfClass:[UINavigationController class]]){
        return  ((UINavigationController *)self).visibleViewController.topVisibleViewController;
    }
    
    if([self isKindOfClass:[UITabBarController class]]){
        return  ((UITabBarController *)self).selectedViewController.topVisibleViewController;
    }
    
    return self;
}

@end
