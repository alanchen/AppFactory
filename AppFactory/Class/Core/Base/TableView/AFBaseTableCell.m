//
//  AFBaseTableCell.m
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFBaseTableCell.h"
#import "LibsHeader.h"
#import "UIView+AFBorder.h"
#import "AppFactory.h"

@interface AFBaseTableCell ()
@property (nonatomic,strong) UIImageView *arrowImageview;
@end

@implementation AFBaseTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.highlightStyle = CellHighllightStyleDefault;
        self.bgColorNormal = [UIColor whiteColor];
        self.bgColorSelected = self.bgColorNormal;
        self.bgColorHightlight = [UIColor colorWithHex:0xF6F6F6];
        
        [self.contentView addSubview: self.bottomLine];
        [self.contentView addSubview: self.topLine];
        
        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(kViewBorderWidth1px));
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(@0);
            make.width.equalTo(self);
        }];
        
        [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(kViewBorderWidth1px));
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(@0);
            make.width.equalTo(self);
        }];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView bringSubviewToFront:self.topLine];
    [self.contentView bringSubviewToFront:self.bottomLine];
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    [self bringSubviewToFront:self.bottomLine];
    [self bringSubviewToFront:self.topLine];
}

#pragma mark - Public

- (UIImageView *) showRightArrow:(BOOL)show
{
    if(show)
        self.accessoryView = self.arrowImageview;
    else
        self.accessoryView = nil;
    
    return self.arrowImageview;
}

#pragma mark - Cell Interface

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if(self.highlightStyle == CellHighlightStyleNone)
        return;

    UIColor *bgColor = selected?self.bgColorSelected:self.bgColorNormal;

    if (selected) {
        self.backgroundColor = bgColor;
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = bgColor;
        } completion:^(BOOL finished) {
            [self setNeedsLayout];
        }];
    }

    [self bringSubviewToFront:self.bottomLine];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];

    if(self.highlightStyle == CellHighlightStyleNone)
        return;
    
    UIColor *bgColor = highlighted?self.bgColorHightlight:self.bgColorNormal;
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = bgColor;
    }];

    [self bringSubviewToFront:self.bottomLine];
}

#pragma  mark - Getter & Setter

-(void)setBgColorNormal:(UIColor *)bgColorNormal
{
    _bgColorNormal = bgColorNormal;
    self.backgroundColor = bgColorNormal;
}

-(UIImageView *)arrowImageview
{
    if(!_arrowImageview){
        _arrowImageview = [[UIImageView alloc] initWithImage:AF_BUNDLE_IMAGE(@"cell-arrow")];
        [_arrowImageview setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    return _arrowImageview;
}

- (UIView *) bottomLine
{
    if(!_bottomLine){
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _bottomLine;
}

- (UIView *) topLine
{
    if(!_topLine){
        _topLine = [[UIView alloc] initWithFrame:CGRectZero];
        _topLine.backgroundColor = [UIColor lightGrayColor];
        _topLine.hidden = YES;
    }
    
    return _topLine;
}

@end
