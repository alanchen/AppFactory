//
//  NSObject+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(AFExtension)

-(id)safelyObjectForKey:(NSString *)key;

-(NSString *)safelyStringForKey:(NSString *)key;

-(NSInteger)safelyIntegerForKey:(NSString *)key;

-(NSString *)toJson;

@end
