//
//  UIBarButtonItem+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIBarButtonItem+AFExtension.h"
#import "LibsHeader.h"

@implementation UIBarButtonItem(AFExtension)

+(UIBarButtonItem *)barItemWithImgName:(NSString *)imgName
                                target:(id)target
                                action:(SEL)action
{
    if(!imgName) return nil;
    UIImage *img = [UIImage imageNamed:imgName];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:img
                                                             style:UIBarButtonItemStylePlain
                                                            target:target
                                                            action:action];
    [item setImageInsets:UIEdgeInsetsZero];
    
    return item;
}

-(void)setNormalTitleTextFont:(UIFont *)font textColor:(UIColor *)color
{
    if(!font || !color)
        return;
    
    id dict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,color, NSForegroundColorAttributeName,nil];
    [self setTitleTextAttributes:dict forState:UIControlStateNormal];
}

-(void)setNormalTitleTextFont:(UIFont *)font
{
    if(!font)
        return;
    
    id dict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    [self setTitleTextAttributes:dict forState:UIControlStateNormal];
}

-(void)setNormalTitleTextColor:(UIColor *)color
{
    if(!color)
        return;
    
    id dict = [NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName,nil];
    [self setTitleTextAttributes:dict forState:UIControlStateNormal];
}

-(void)setCustomViewSize:(CGSize)size
{
    UIView *view = self.customView;
    view.size = size;
    
    if (@available(iOS 9, *)) {
        [view.widthAnchor constraintEqualToConstant: size.width].active = YES;
        [view.heightAnchor constraintEqualToConstant: size.height].active = YES;
    }
}

@end
