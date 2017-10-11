//
//  PMCountryCell.m
//  PigMarket
//
//  Created by alan on 2015/7/16.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "AFCountryCell.h"
#import "LibsHeader.h"

@implementation AFCountryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subtitleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(self.contentView);
            make.width.greaterThanOrEqualTo(@10);
            make.height.equalTo(@22);
        }];
        
        [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@95);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right).with.offset(-15);
            make.height.equalTo(@22);
        }];
        
        self.tintColor = [UIColor redColor];
    }
    
    return self;
}

#pragma mark - Setter & Getter

-(UILabel *)titleLabel
{
    if(!_titleLabel){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 1;
        _titleLabel = label;
    }
    
    return _titleLabel;
}

-(UILabel *)subtitleLabel
{
    if(!_subtitleLabel){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 1;
        _subtitleLabel = label;
    }
    
    return _subtitleLabel;
}

@end
