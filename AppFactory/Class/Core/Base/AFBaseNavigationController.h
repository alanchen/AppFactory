//
//  AFBaseNavigationController.h
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AFBaseNavigationController : UINavigationController

+(AFBaseNavigationController *)navigationWithRootViewController:(UIViewController *)rootViewController;

@end

