//
//  UIImage+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage(AFExtension)

+ (UIImage *)imageCircleWithRadius:(float)r color:(UIColor *)color;

- (UIImage *)circleImage;

+ (UIImage *)imageFrom:(NSBundle *)bundle name:(NSString *)name;


@end
