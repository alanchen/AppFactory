//
//  UILabel+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UILabel(AFExtension)

- (void)sizeToFitTheSize:(CGSize)size;

- (void)sizeToFitTheAttributedSize:(CGSize)size;

- (void)setHTMLText:(NSString*)html sizeTofit:(CGSize )size;

- (NSInteger)lineCount;

@end
