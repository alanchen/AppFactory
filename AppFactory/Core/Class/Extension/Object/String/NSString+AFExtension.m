//
//  NSString+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "NSString+AFExtension.h"

@implementation NSString(AFExtension)

+ (NSString *)stringDecimalStyleWithNumber:(NSInteger)number
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:@(number)];
    return formattedNumberString;
}

+ (NSString*) stringAbbreviateWithNumber:(NSInteger)numInt
{
    int s = ( (numInt < 0) ? -1 : (numInt > 0) ? 1 : 0 );
    NSString* sign = (s == -1 ? @"-" : @"" );
    
    long long num = llabs(numInt);
    
    if (num < 1000)
        return [NSString stringWithFormat:@"%@%zd",sign,num];
    
    int exp = (int) (log(num) / log(1000));
    
    NSArray* units = @[@"K",@"M",@"G",@"T",@"P",@"E"];
    
    return [NSString stringWithFormat:@"%@%.1f%@",sign, (num / pow(1000, exp)), [units objectAtIndex:(exp-1)]];
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedSize:(CGSize)size
{
    id  attributes = @{NSFontAttributeName:font};
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}

- (BOOL)af_containsString:(NSString *)aString
{
    return [self rangeOfString:aString].location != NSNotFound ;
}

- (BOOL)af_containsChinese
{
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

- (NSString *) firstChar
{
    if([self length]<1)
        return nil;
    
    NSString *firstLetter = [self substringToIndex:1];
    
    return firstLetter;
}

- (NSString *) lastChar
{
    if([self length]<1)
        return nil;
    
    NSInteger lastIndex = [self length] - 1;
    if(lastIndex < 0)
        return nil;
    
    NSString *lastChar = [self substringFromIndex:lastIndex];
    return lastChar;
}

- (NSString *)stringByTrimmingWhitespaceAndNewline
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)removeWhitespaceAndNewline
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimContent = [[self componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    return  trimContent;
}


- (BOOL) isVersionHigherThanVersion:(NSString *)v2
{
    NSComparisonResult cr = [self compare:v2 options:NSNumericSearch];
    if(cr == NSOrderedDescending)
        return YES;
    return NO;
}

- (BOOL) isVersionLowerThanVersion:(NSString *)v2
{
    NSComparisonResult cr = [self compare:v2 options:NSNumericSearch];
    
    if(cr == NSOrderedAscending)
        return YES;
    
    return NO;
    
}

@end
