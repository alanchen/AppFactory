//
//  NSAttributedString+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString(AFExtension)

+ (NSAttributedString *) stringWithHTMLString:(NSString *)str sizeTofit:(CGSize )size;

+ (NSAttributedString *) stringWithHTMLString:(NSString *)str;

- (CGSize) sizeWithConstrainedSize:(CGSize)limitSize;

- (NSRange) allRange;

- (NSRange) rangeMoveOnFromLocationRange:(NSRange)fromRange;

@end
