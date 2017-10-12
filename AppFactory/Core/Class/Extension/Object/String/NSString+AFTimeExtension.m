//
//  NSString+AFTimeExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/28.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "NSString+AFTimeExtension.h"
#import "DateTools.h"

@implementation NSString(AFTimeExtension)

+(NSString *)stringWeeksAgorWithTimeInterval:(NSTimeInterval)time
{
    if(time==0) return @"";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [date weekTimeAgoSinceNow];
}

+(NSString *)stringWithTimeFormat:(NSString *)format withTimeInterval:(NSTimeInterval )time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [date formattedDateWithFormat:format];
}

+(NSString *)stringYYYYMMddWithTimeInterval:(NSTimeInterval )time
{
    return [self stringWithTimeFormat:@"yyyy/MM/dd" withTimeInterval:time];
}

+(NSString *)stringYYYY_MM_dd_HH_mm_ssWithTimeInterval:(NSTimeInterval )time
{
    return [self stringWithTimeFormat:@"yyyy/MM/dd HH:mm:ss" withTimeInterval:time];
}

+(NSString *)stringTimeAgoWithTimeInterval:(NSTimeInterval )time
{
    if(time==0) return @"";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [date timeAgoSinceNow];
}

#pragma mark -

+(NSString *)stringWithTimeFormat:(NSString *)format showAgoDays:(NSInteger)showAgoDays timeInterval:(NSTimeInterval )time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSInteger daysAgo = [date daysAgo];
    if(daysAgo <= showAgoDays)
        return [date timeAgoSinceNow];
    
    return [date formattedDateWithFormat:format];;
}

+(NSString *)stringFullFormatWithTimeInterval:(NSTimeInterval )time
{
   return [self stringWithTimeFormat:@"yyyy/MM/dd HH:mm a" showAgoDays:365 timeInterval:time];
}

+(NSString *)stringShortFormatWithTimeInterval:(NSTimeInterval )time
{
    return [self stringWithTimeFormat:@"yyyy/MM/dd" showAgoDays:365 timeInterval:time];
}

+(NSString *)stringCommonFormatWithTimeInterval:(NSTimeInterval )time
{
    return [self stringWithTimeFormat:@"yyyy/MM/dd" showAgoDays:7 timeInterval:time];
}

#pragma mark -

+(NSString *)stringChatRoomFormatWithTimeInterval:(NSTimeInterval )time
{
    return [self stringWithTimeFormat:@"yyyy/MM/dd" showAgoDays:365 timeInterval:time];
}

+(NSString *)stringChatTimeFormatWithTimeInterval:(NSTimeInterval )time
{
    return [self stringWithTimeFormat:@"ah:mm" withTimeInterval:time];
}

+(NSString *)stringChatForTimeSeparatorWithTimeInterval:(NSTimeInterval)time;
{
    if(time==0)
        return @"";

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];

    if([date isYesterday]){
        return DateToolsLocalizedStrings(@"Yesterday");
    }

    if([date isToday]){
        return DateToolsLocalizedStrings(@"Today");
    }
    
    NSInteger daysAgo = [date daysAgo];
    if(daysAgo <= 90){
        return [date formattedDateWithFormat:@"MM/dd (E)"];
    }

    return [date formattedDateWithFormat:@"yyyy/MM/dd (E)"];
}

@end
