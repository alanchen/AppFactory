//
//  NSMutableArray+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "NSMutableArray+AFExtension.h"

@implementation NSMutableArray(AFExtension)

-(void)safelyInsertObjectToFront:(id)anObject
{
    if([self count]==0)
        [self  addObject:anObject];
    else
        [self insertObject:anObject atIndex:0];
}

-(void)safelyAddObject:(id)anObject
{
    if(!anObject)
        return;
    
    [self addObject:anObject];
}

- (void)safelyAddObjectsFromArray:(NSArray *)objects
{
    if(![objects isKindOfClass:[NSArray class]])
        return;
    
    if([objects count]==0)
        return;
    
    [self addObjectsFromArray:objects];
}

- (void)safelyReplaceObjectAtIndex:(NSInteger)idx withObject:(id)anObject
{
    if(!anObject)
        return;
    
    if(idx >= [self count])
        return;
    
    if(idx < 0)
        return;
    
    [self replaceObjectAtIndex:idx withObject:anObject];
}

@end
