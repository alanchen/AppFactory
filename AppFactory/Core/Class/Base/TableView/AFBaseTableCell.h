//
//  AFBaseTableCell.h
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CellHighllightStyleDefault = 0,
    CellHighlightStyleNone
} CellHighlightStyle;

#define  kSeparatorLineHeight (1.0 / [UIScreen mainScreen].scale)

@interface AFBaseTableCell : UITableViewCell

@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UIView *topLine;

@property (nonatomic) CellHighlightStyle highlightStyle;
@property (nonatomic,strong) UIColor *bgColorNormal;
@property (nonatomic,strong) UIColor *bgColorHightlight;
@property (nonatomic,strong) UIColor *bgColorSelected;

- (UIImageView *) showRightArrow:(BOOL)show;

@end

