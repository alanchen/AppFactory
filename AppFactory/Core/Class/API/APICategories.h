//
//  APICategories.h
//  PigMarket
//
//  Created by alan on 2015/6/18.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(AF_API)

-(NSInteger)resStatusCode;
-(NSArray *)resItems;
-(NSString *)resError;
-(NSString *)resReason;

@end

@interface NSMutableDictionary (AF_API)

+(NSMutableDictionary *)paramsWithOffset:(NSInteger)offset limit:(NSInteger)limit;
-(void)setReqOffset:(NSInteger)offset;
-(void)setReqLimit:(NSInteger)limit;

@end

@interface NSString(AF_API)

+ (NSString *)stringUrl:(NSString *)url appendId:(NSInteger)anId;
+ (NSString *)stringUrl:(NSString *)url appendString:(NSString *)str;

@end

