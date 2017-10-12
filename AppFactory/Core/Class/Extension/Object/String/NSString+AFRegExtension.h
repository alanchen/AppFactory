//
//  NSString+AFRegExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(AFRegExtension)

- (BOOL) isValidEmail;

- (BOOL) isValidUrl;

- (BOOL) isAllDigits;

- (void) findMatchesRegex:(NSString *)regexString enumBlock:(void (^)(NSRange matchRange))enumBlock;

- (void) findLinksWithEnumBlock:(void (^)(NSRange matchRange, NSString *link))enumBlock;

@end
