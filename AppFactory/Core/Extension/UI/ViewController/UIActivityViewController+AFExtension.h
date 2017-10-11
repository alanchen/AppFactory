//
//  UIActivityViewController+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIActivityViewController(AFExtension)

+ (UIActivityViewController *)showWithActivityItems:(NSArray *)items
                                   onViewController:(UIViewController *)viewController
                                         sourceView:(UIView *)sourceView;

@end
