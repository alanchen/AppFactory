//
//  NSString+AFTimeExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/28.
//  Copyright © 2017年 alan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(AFTimeExtension)

+(NSString *)stringWeeksAgorWithTimeInterval:(NSTimeInterval)time;
+(NSString *)stringWithTimeFormat:(NSString *)format withTimeInterval:(NSTimeInterval )time;
+(NSString *)stringYYYYMMddWithTimeInterval:(NSTimeInterval )time;
+(NSString *)stringYYYY_MM_dd_HH_mm_ssWithTimeInterval:(NSTimeInterval )time;
+(NSString *)stringTimeAgoWithTimeInterval:(NSTimeInterval )time;

#pragma mark -

+(NSString *)stringWithTimeFormat:(NSString *)format showAgoDays:(NSInteger)showAgoDays timeInterval:(NSTimeInterval )time;
+(NSString *)stringFullFormatWithTimeInterval:(NSTimeInterval )time;
+(NSString *)stringShortFormatWithTimeInterval:(NSTimeInterval )time;
+(NSString *)stringCommonFormatWithTimeInterval:(NSTimeInterval )time;

#pragma mark -

+(NSString *)stringChatRoomFormatWithTimeInterval:(NSTimeInterval )time;
+(NSString *)stringChatTimeFormatWithTimeInterval:(NSTimeInterval )time;
+(NSString *)stringChatForTimeSeparatorWithTimeInterval:(NSTimeInterval)time;

@end
