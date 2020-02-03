//
//  UITextField+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UITextField+AFExtension.h"
#import "NSMutableAttributedString+AFExtension.h"

@implementation UITextField(AFExtension)

//-(void)setPlaceholderColor:(UIColor *)color
//{
//    if(!color)
//        return;
//    
//    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
//}
//
//-(void)setPlaceholderFont:(UIFont *)font
//{
//    if(!font)
//        return;
//    
//    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
//}

-(void)setPlaceholder:(NSString *)placeholderStr font:(UIFont *)font color:(UIColor *)color
{
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:placeholderStr];
    [placeholder setAllTextWithFont:font color:color];
    self.attributedPlaceholder = placeholder;
}

@end
