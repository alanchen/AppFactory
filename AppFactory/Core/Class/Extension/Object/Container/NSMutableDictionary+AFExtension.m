//
//  NSMutableDictionary+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "NSMutableDictionary+AFExtension.h"

@implementation NSMutableDictionary(AFExtension)

-(void)safelySetObject:(id)anObject forKey:(NSString *)aKey
{
    if(anObject && aKey){
        [self setObject:anObject forKey:aKey];
    }
}

-(void)safelySetIntParam:(NSInteger)intValue forKey:(NSString *)aKey
{
    [self safelySetObject:@(intValue) forKey:aKey];
}

-(void)safelySetBoolParam:(BOOL)boolValue forKey:(NSString *)aKey
{
    [self safelySetObject:@(boolValue) forKey:aKey];
}

@end
