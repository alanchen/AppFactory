//
//  UITextField+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UITextField+AFExtension.h"

@implementation UITextField(AFExtension)

-(void)setPlaceholderColor:(UIColor *)color
{
    if(!color)
        return;
    
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

-(void)setPlaceholderFont:(UIFont *)font
{
    if(!font)
        return;
    
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}


@end
