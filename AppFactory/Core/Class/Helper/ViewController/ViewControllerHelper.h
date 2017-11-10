//
//  ViewControllerHelper.h
//  AppFactory
//
//  Created by alan on 2017/10/9.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITabBarController+AFExtension.h"

@interface ViewControllerHelper : NSObject

+(UIViewController *)currentViewController;

+(void)switchMainTabBarToSelectedIndex:(NSUInteger)selectedIndex
                             popToRoot:(BOOL)popToRoot
                        withCompletion:(void (^)(void))completion;


@end
