//
//  UIColor+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/16.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIColor+AFExtension.h"

@implementation UIColor(AFExtension)

+(UIColor *)color24WithR:(float)r G:(float)g  B:(float)b A:(float)a
{
    return[UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:a];
}

+(UIColor *)hexRGBA:(UInt32)hex
{
    return [UIColor colorWithHex:hex];
}

+(UIColor *)random
{
    return [UIColor color24WithR:(arc4random()%256) G:(arc4random()%256) B:(arc4random()%256) A:1.0];
}

- (UIColor * (^)(CGFloat))withAlpha {
    return ^id(CGFloat a){
        return  [self colorWithAlphaComponent:a];
    };
}

+ (UIColor *)fadeFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor withPercentage:(CGFloat)percentage
{
    // get the RGBA values from the colours
    CGFloat fromRed, fromGreen, fromBlue, fromAlpha;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed, toGreen, toBlue, toAlpha;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    //calculate the actual RGBA values of the fade colour
    CGFloat red = (toRed - fromRed) * percentage + fromRed;
    CGFloat green = (toGreen - fromGreen) * percentage + fromGreen;
    CGFloat blue = (toBlue - fromBlue) * percentage + fromBlue;
    CGFloat alpha = (toAlpha - fromAlpha) * percentage + fromAlpha;
    
    // return the fade colour
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@end
