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
