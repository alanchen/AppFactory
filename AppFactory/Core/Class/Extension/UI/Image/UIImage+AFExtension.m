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

@end
