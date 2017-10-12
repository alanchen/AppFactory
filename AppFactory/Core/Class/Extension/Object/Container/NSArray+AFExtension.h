//
//  NSArray+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray(AFExtension)

- (id)safelyObjectAtIndex:(NSUInteger)index;

- (void)enumObjsByBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;

- (NSArray *)arrayWithClass:(Class)c;

@end
