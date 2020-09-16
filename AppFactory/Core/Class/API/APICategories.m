//
//  APICategories.m
//  PigMarket
//
//  Created by alan on 2015/6/18.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "APICategories.h"
#import "NSObject+AFExtension.h"

@implementation NSDictionary(AF_API)

-(NSInteger)resStatusCode
{
    return [[self safelyObjectForKey:@"status"] integerValue];
}

-(NSArray *)resItems
{
    return [self safelyObjectForKey:@"items"];
}

-(NSString *)resError
{
    return [self safelyObjectForKey:@"error"];
}

-(NSString *)resReason
{
    return [self safelyObjectForKey:@"reason"];
}

@end

@implementation NSMutableDictionary (AF_API)

+ (NSMutableDictionary *)paramsWithOffset:(NSInteger)offset limit:(NSInteger)limit
{
    id params = [@{} mutableCopy];
    
    [params setReqLimit:limit];
    [params setReqOffset:offset];
    
    return params;
}

-(void)setReqOffset:(NSInteger)offset
{
    if(offset>=0)
        self[@"offset"] = @(offset);
}

-(void)setReqLimit:(NSInteger)limit
{
    if(limit>=0)
        self[@"limit"] = @(limit);
}

@end

@implementation NSString(AF_API)

+ (NSString *)stringUrl:(NSString *)url appendId:(NSInteger)anId
{
    return [NSString stringUrl:url appendString:[NSString stringWithFormat:@"%zd",anId]];
}

+ (NSString *)stringUrl:(NSString *)url appendString:(NSString *)str
{
    if(str)
        url = [url stringByAppendingPathComponent:str];
    
    return url;
}

@end

