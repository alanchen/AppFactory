//
//  NSObject+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "NSObject+AFExtension.h"

@implementation NSObject(AFExtension)

-(id)safelyObjectForKey:(NSString *)key
{
    if(![self isKindOfClass:[NSDictionary class]])
        return nil;
    
    NSDictionary *dict = (NSDictionary *)self;
    id obj = [dict objectForKey:key];
    
    if([obj isKindOfClass:[NSNull class]])
        return nil;
    
    return obj;
}

-(NSString *)safelyStringForKey:(NSString *)key
{
    if(![self isKindOfClass:[NSDictionary class]])
        return nil;
    
    NSDictionary *dict = (NSDictionary *)self;
    id obj = [dict objectForKey:key];
    
    if([obj isKindOfClass:[NSNull class]])
        return nil;
    
    if([obj isKindOfClass:[NSString class]])
        return obj;
    
    if([obj respondsToSelector:@selector(stringValue)]){
        return [obj stringValue];
    }
    
    return nil;
}

-(NSInteger)safelyIntegerForKey:(NSString *)key
{
    id obj = [self safelyObjectForKey:key];
    
    if([obj respondsToSelector:@selector(integerValue)]){
        return [obj integerValue];
    }
    
    return 0;
}

- (NSString *)toJson
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    
    if (! jsonData) {
        if([self isKindOfClass:[NSDictionary class]]){
            return @"{}";
        }else if([self isKindOfClass:[NSArray class]]){
            return @"[]";
        }else{
            return @"";
        }
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
