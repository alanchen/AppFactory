//
//  NSArray+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "NSArray+AFExtension.h"

@implementation NSArray(AFExtension)

-(id)safelyObjectAtIndex:(NSUInteger)index
{
    if(index >= [self count])
        return nil;
    
    return [self objectAtIndex:index];
}

- (void)enumObjsByBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block // *stop = YES will break blcok
{
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj, idx, stop);
    }];
}

-(NSArray *)arrayWithClass:(Class)classname
{
    NSMutableArray *arr = [NSMutableArray array];
    
    [self enumObjsByBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:classname]){
            [arr addObject:obj];
        }
    }];
    
    return [arr copy];
}

@end
