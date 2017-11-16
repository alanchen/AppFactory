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

+ (UIImage *)imageGradientVerticalFromColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size;

+ (UIImage *)imageGradientHorizatalFromColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;


@end
