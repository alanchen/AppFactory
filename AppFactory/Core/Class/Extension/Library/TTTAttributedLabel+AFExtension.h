//
//  TTTAttributedLabel+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/22.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface TTTAttributedLabel(AFExension)

-(void)setText:(NSString *)text linkTexts:(NSArray *)linkTexts links:(NSArray *)links linkColor:(UIColor *)linkColor linkFont:(UIFont *)linkFont;

@end

//#pragma mark - TTTAttributedLabelDelegate
//- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
//    if([url.absoluteString isEqualToString:link]){
//    }
//}

