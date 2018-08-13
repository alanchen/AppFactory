//
//  TTTAttributedLabel+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/22.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "TTTAttributedLabel+AFExtension.h"
#import "UIColor+AFExtension.h"

@implementation TTTAttributedLabel(AFExension)

-(void)setText:(NSString *)text linkTexts:(NSArray *)linkTexts links:(NSArray *)links linkColor:(UIColor *)linkColor linkFont:(UIFont *)linkFont
{
    [self setText:text underline:NO linkTexts:linkTexts links:links linkColor:linkColor linkFont:linkFont];
}

-(void)setText:(NSString *)text
     underline:(BOOL)showUnderline
     linkTexts:(NSArray *)linkTexts
         links:(NSArray *)links
     linkColor:(UIColor *)linkColor
      linkFont:(UIFont *)linkFont
{
    NSMutableDictionary *mutableLinkAttributes = [NSMutableDictionary dictionary];
    NSMutableDictionary *mutableActiveLinkAttributes = [NSMutableDictionary dictionary];
    NSMutableDictionary *mutableInactiveLinkAttributes = [NSMutableDictionary dictionary];

    [mutableLinkAttributes setObject:@(showUnderline) forKey:(NSString *)kCTUnderlineStyleAttributeName];
    [mutableActiveLinkAttributes setObject:@(showUnderline) forKey:(NSString *)kCTUnderlineStyleAttributeName];
    [mutableInactiveLinkAttributes setObject:@(showUnderline) forKey:(NSString *)kCTUnderlineStyleAttributeName];
    
    [mutableLinkAttributes setObject:linkColor forKey:(NSString *)kCTForegroundColorAttributeName];
    [mutableActiveLinkAttributes setObject:linkColor.withAlpha(0.6) forKey:(NSString *)kCTForegroundColorAttributeName];
    [mutableInactiveLinkAttributes setObject:linkColor.withAlpha(0.5)  forKey:(NSString *)kCTForegroundColorAttributeName];
    
    [mutableLinkAttributes setObject:linkFont forKey:(NSString *)kCTFontAttributeName];
    [mutableActiveLinkAttributes setObject:linkFont forKey:(NSString *)kCTFontAttributeName];
    [mutableInactiveLinkAttributes setObject:linkFont forKey:(NSString *)kCTFontAttributeName];
    
    self.linkAttributes = [mutableLinkAttributes copy];
    self.activeLinkAttributes = [mutableActiveLinkAttributes copy];
    self.inactiveLinkAttributes = [mutableInactiveLinkAttributes copy];
    
    [self setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString){
        return mutableAttributedString;
    }];

    self.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    [linkTexts enumerateObjectsUsingBlock:^(NSString *linkTxt, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:linkTxt];
        NSString *link = [links objectAtIndex:idx];
        [self addLinkToURL:[NSURL URLWithString:link] withRange:range];
    }];
}


@end
