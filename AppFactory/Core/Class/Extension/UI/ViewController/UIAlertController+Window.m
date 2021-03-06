//
//  UIAlertController+Window.m
//  PigMarket
//
//  Created by alan on 2017/8/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIAlertController+Window.h"
#import <objc/runtime.h>

@interface UIAlertController (Private)

@property (nonatomic, strong) UIWindow *alertWindow;

@end

@implementation UIAlertController (Private)

@dynamic alertWindow;

- (void)setAlertWindow:(UIWindow *)alertWindow {
    objc_setAssociatedObject(self, @selector(alertWindow), alertWindow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIWindow *)alertWindow {
    return objc_getAssociatedObject(self, @selector(alertWindow));
}

- (UIWindow *)appDelegateWindow
{
    // Applications that does not load with UIMainStoryboardFile might not have a window property:
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    if ([delegate respondsToSelector:@selector(window)]) {
        return delegate.window;
    }
    
    return nil;
}

@end

@implementation  UIAlertController(Window)

- (void)show {
    [self show:YES];
}

- (void)show:(BOOL)animated {
    self.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.alertWindow.rootViewController = [[UIViewController alloc] init];
    
    // we inherit the main window's tintColor
//    self.alertWindow.tintColor = [self appDelegateWindow].tintColor;
    self.alertWindow.windowLevel = UIWindowLevelAlert + 1;
    [self.alertWindow makeKeyAndVisible];
    [self.alertWindow.rootViewController presentViewController:self animated:animated completion:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.alertWindow resignKeyWindow];
    self.alertWindow.hidden = YES;
    self.alertWindow = nil;
    [[self appDelegateWindow] makeKeyAndVisible];
}

@end
