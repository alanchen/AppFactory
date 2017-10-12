//
//  NSString+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(AFExtension)

+ (NSString *) stringDecimalStyleWithNumber:(NSInteger)number; // 1000 ---> 1,000

+ (NSString*) stringAbbreviateWithNumber:(NSInteger)number; // 52935 ---> 53K

- (CGSize) sizeWithFont:(UIFont *)font constrainedSize:(CGSize)size;

- (BOOL) af_containsString:(NSString *)aString;

- (BOOL)af_containsChinese;

- (NSString *) firstChar;

- (NSString *) lastChar;

- (NSString *) stringByTrimmingWhitespaceAndNewline;

- (NSString *) removeWhitespaceAndNewline;

- (BOOL) isVersionHigherThanVersion:(NSString *)v2;

- (BOOL) isVersionLowerThanVersion:(NSString *)v2;



@end
