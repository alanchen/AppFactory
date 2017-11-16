//
//  UIImage+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIImage+AFExtension.h"

@implementation UIImage(AFExtension)

+ (UIImage *)imageCircleWithRadius:(float)r color:(UIColor *)color
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect circleRect = CGRectMake( 0, 0, r*2, r*2);
    
    UIGraphicsBeginImageContextWithOptions(circleRect.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillEllipseInRect(context, circleRect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)circleImage
{
    float scale = [UIScreen mainScreen].scale;
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);

    UIGraphicsBeginImageContextWithOptions(self.size,NO,scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageFrom:(NSBundle *)bundle name:(NSString *)name
{
    NSInteger scale = (NSInteger)[[UIScreen mainScreen] scale];
    
    for (NSInteger i = scale ; i >= 1; i--) {
        UIImage *tempImage = [UIImage imageFrom:bundle name:name scale:i];
        if (tempImage) {
            return tempImage;
        }
    }
    
    for (NSInteger i = scale + 1 ; i <= 3; i++) {
        UIImage *tempImage = [UIImage imageFrom:bundle name:name scale:i];
        if (tempImage) {
            return tempImage;
        }
    }
    
    return nil;
}

+ (UIImage *)imageGradientHorizatalFromColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width,size.height);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    UIGraphicsBeginImageContext([gradientLayer frame].size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

+ (UIImage *)imageGradientVerticalFromColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width,size.height);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    
    UIGraphicsBeginImageContext([gradientLayer frame].size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:blendMode alpha:1.0];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

#pragma mark - Private

+ (UIImage *)imageFrom:(NSBundle *)bundle name:(NSString *)name scale:(NSInteger)scale
{
    NSString *bundlePath = [bundle bundlePath];
    NSString *imgPath = [bundlePath stringByAppendingPathComponent:name];
    NSString *pathExtension = [imgPath pathExtension];
    if (!pathExtension || pathExtension.length == 0) {
        pathExtension = @"png";
    }
    
    NSString *imageName = [[imgPath lastPathComponent] stringByDeletingPathExtension];
    if (scale == 1) {
        imageName = [NSString stringWithFormat:@"%@.%@", imageName, pathExtension];
    }else {
        imageName = [NSString stringWithFormat:@"%@@%zdx.%@", imageName, scale, pathExtension];
    }
    
    NSString *imageFilePath = [[imgPath stringByDeletingLastPathComponent] stringByAppendingPathComponent:imageName];
    return [UIImage imageWithContentsOfFile:imageFilePath];
}

@end
