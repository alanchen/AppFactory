//
//  UITextView+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//
#import "UITextView+AFExtension.h"
#import "NSString+AFExtension.h"
#import "NSAttributedString+AFExtension.h"
#import "LibsHeader.h"

@implementation UITextView(AFExtension)

- (void)sizeToFitTheSize:(CGSize)size
{
    [self.text sizeWithFont:self.font constrainedSize:size];
    self.size = [self.text sizeWithFont:self.font constrainedSize:size];
}

- (void)sizeToFitTheAttrributedSize:(CGSize)size
{
    CGSize resultSize =  [self.attributedText sizeWithConstrainedSize:size];
    self.size = resultSize;
}

- (void)setHTMLText:(NSString*)html sizeTofit:(CGSize )size
{
    NSAttributedString *attributedString = [NSAttributedString stringWithHTMLString:html sizeTofit:size];
    [self setAttributedText:attributedString];
}

@end
