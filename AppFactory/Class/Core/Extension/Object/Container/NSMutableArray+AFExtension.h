//
//  NSMutableArray+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray(AFExtension)

- (void)safelyInsertObjectToFront:(id)anObject;

- (void)safelyAddObject:(id)anObject;

- (void)safelyAddObjectsFromArray:(NSArray *)objects;

- (void)safelyReplaceObjectAtIndex:(NSInteger)idx withObject:(id)anObject;

@end
