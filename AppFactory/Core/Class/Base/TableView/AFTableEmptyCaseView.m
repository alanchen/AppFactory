//
//  AFTableEmptyCaseView.m
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFTableEmptyCaseView.h"
#import "AppFactory.h"
#import "LibsHeader.h"

@implementation AFTableEmptyCaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.icon = [[UIImageView alloc] initWithImage:AF_BUNDLE_IMAGE(@"table-empty-icon")];
        [self addSubview:self.icon];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label.numberOfLines = 0;
        self.label.textColor = [UIColor colorWithHex:0xA0A0A0];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = [UIFont systemFontOfSize:16];;
        [self addSubview:self.label];
        self.label.text = @"沒有內容";
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.height.greaterThanOrEqualTo(@10);
            make.width.greaterThanOrEqualTo(@10);
        }];
        
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@25);
            make.height.equalTo(@25);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.label.mas_top).with.offset(-10);
        }];
    }
    return self;
}

@end
