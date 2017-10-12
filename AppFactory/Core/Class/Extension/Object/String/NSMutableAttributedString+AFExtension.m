//
//  NSMutableAttributedString+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "NSMutableAttributedString+AFExtension.h"
#import "NSAttributedString+AFExtension.h"
#import <CoreText/CoreText.h>

@implementation NSMutableAttributedString (AFExtension)

+(NSMutableAttributedString *) nexLine{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    return str;
}

+(NSMutableAttributedString *) stringWith:(NSString *)str{
    if(!str) return nil;
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:str];
    return result;
}

#pragma mark -

-(void)setText:(NSString *)text font:(UIFont *)font
{
    NSRange range = [self.string rangeOfString:text];
    while(range.location != NSNotFound){
        [self addAttribute:(NSString *)NSFontAttributeName value:font range:range];
        NSRange rangeToSearch = [self rangeMoveOnFromLocationRange:range];
        range = [self.string rangeOfString:text options:0 range:rangeToSearch];
    }
}

-(void)setText:(NSString *)text color:(UIColor *)color
{
    NSRange range = [self.string rangeOfString:text];
    while(range.location != NSNotFound){
        [self addAttribute:(NSString *)NSForegroundColorAttributeName value:(id)color range:range];
        [self addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)color.CGColor range:range];
        NSRange rangeToSearch = [self rangeMoveOnFromLocationRange:range];
        range = [self.string rangeOfString:text options:0 range:rangeToSearch];
    }
}

-(void)setText:(NSString *)text font:(UIFont *)font color:(UIColor *)color
{
    [self setText:text color:color];
    [self setText:text font:font];
}

#pragma mark -

-(void)setAllTextWithFont:(UIFont *)font
{
    NSRange range = [self allRange];
    [self addAttribute:(NSString *)NSFontAttributeName value:font range:range];
}

-(void)setAllTextWithColor:(UIColor *)color
{
    NSRange range = [self allRange];
    [self addAttribute:(NSString *)NSForegroundColorAttributeName value:(id)color range:range];
}

-(void)setAllTextWithFont:(UIFont *)font color:(UIColor *)color
{
    [self setAllTextWithFont:font];
    [self setAllTextWithColor:color];
}

#pragma mark -

-(void)setLineSpaceHeight:(float)height textAligment:(NSTextAlignment)textAlignment
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:height];
    [style setAlignment:textAlignment];
    [self addAttribute:NSParagraphStyleAttributeName value:style range:[self allRange]];
}

-(void)deleteStrings:(NSString *)str
{
    NSRange range = [self.string rangeOfString:str];
    while (range.location != NSNotFound) {
        [self deleteCharactersInRange:range];
        range = [self.string rangeOfString:str];
    }
}

@end
