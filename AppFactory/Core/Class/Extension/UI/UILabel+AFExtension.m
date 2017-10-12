//
//  UILabel+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UILabel+AFExtension.h"
#import "NSString+AFExtension.h"
#import "NSAttributedString+AFExtension.h"
#import "LibsHeader.h"

@implementation UILabel(AFExtension)

- (void)sizeToFitTheSize:(CGSize)size
{
    CGSize fitSize = [self sizeThatFits:size];
    self.size = CGSizeMake(MIN(fitSize.width, size.width), MIN(fitSize.height, size.height));
}

- (void)sizeToFitTheAttributedSize:(CGSize)size
{
    CGSize resultSize =  [self.attributedText sizeWithConstrainedSize:size];
    self.size = resultSize;
}

- (void)setHTMLText:(NSString*)html sizeTofit:(CGSize )size
{
    NSAttributedString *attributedString = [NSAttributedString stringWithHTMLString:html sizeTofit:size];
    [self setAttributedText:attributedString];
}

- (NSInteger)lineCount
{
    CGSize constrain = CGSizeMake(self.bounds.size.width, FLT_MAX);
    CGSize size =[self.text sizeWithFont:self.font constrainedSize:constrain];
    return ceil(size.height / self.font.lineHeight);
}

@end
