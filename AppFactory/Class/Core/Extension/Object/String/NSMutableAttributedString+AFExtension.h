//
//  NSMutableAttributedString+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (AFExtension)

+(NSMutableAttributedString *) nexLine;
+(NSMutableAttributedString *) stringWith:(NSString *)str;

-(void)setText:(NSString *)text font:(UIFont *)font;
-(void)setText:(NSString *)text color:(UIColor *)color;
-(void)setText:(NSString *)text font:(UIFont *)font color:(UIColor *)color;

-(void)setAllTextWithFont:(UIFont *)font;
-(void)setAllTextWithColor:(UIColor *)color;
-(void)setAllTextWithFont:(UIFont *)font color:(UIColor *)color;

-(void)deleteStrings:(NSString *)str;
-(void)setLineSpaceHeight:(float)height textAligment:(NSTextAlignment)textAlignment;

@end
