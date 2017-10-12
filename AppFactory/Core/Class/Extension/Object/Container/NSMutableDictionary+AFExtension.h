//
//  NSMutableDictionary+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(AFExtension)

-(void)safelySetObject:(id)anObject forKey:(NSString *)aKey;

-(void)safelySetIntParam:(NSInteger)intValue forKey:(NSString *)aKey;

-(void)safelySetBoolParam:(BOOL)boolValue forKey:(NSString *)aKey;

@end
