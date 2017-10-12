//
//  NSAttributedString+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "NSAttributedString+AFExtension.h"

@implementation NSAttributedString(AFExtension)

+ (NSAttributedString *) stringWithHTMLString:(NSString *)str sizeTofit:(CGSize )size
{
    if( CGSizeEqualToSize(size, CGSizeZero)){
        float width = [UIScreen mainScreen].bounds.size.width * 0.8;
        size = CGSizeMake(width, 10000);
    }
       
    NSString *imgWidthStr = [NSString stringWithFormat: @"<img width=%.0f height=auto",size.width];
    NSString *html = [str stringByReplacingOccurrencesOfString:@"<img" withString:imgWidthStr];
    
    NSAttributedString *attributedString =
    [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding]
                                     options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                          documentAttributes:nil
                                       error:nil];
    return attributedString;
}

+ (NSAttributedString *) stringWithHTMLString:(NSString *)str
{
    float width = [UIScreen mainScreen].bounds.size.width * 0.8;
    NSString *imgWidthStr = [NSString stringWithFormat: @"<img width=%.0f height=auto",width];
    NSString *html = [str stringByReplacingOccurrencesOfString:@"<img" withString:imgWidthStr];
    
    NSAttributedString *attributedString =
    [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding]
                                     options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                          documentAttributes:nil
                                       error:nil];
    return attributedString;
}

- (CGSize)sizeWithConstrainedSize:(CGSize)limitSize
{
    // https://github.com/casscqt/lineSpaceTextHeightDemo
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [self boundingRectWithSize:limitSize options:options context:nil];
    return CGSizeMake(rect.size.width, rect.size.height +1);
}

-(NSRange) allRange
{
    NSRange range = [self.string rangeOfString:self.string];
    return range;
}

-(NSRange) rangeMoveOnFromLocationRange:(NSRange)fromRange
{
    return NSMakeRange(fromRange.location + 1, [self.string length] - fromRange.location - 1);
}

@end
