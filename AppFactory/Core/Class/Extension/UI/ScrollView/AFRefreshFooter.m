//
//  AFRefreshFooter.m
//  AppFactory
//
//  Created by alan on 2017/11/6.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFRefreshFooter.h"

@implementation AFRefreshFooter

- (UIActivityIndicatorView *)spinner
{
    if (!_spinner) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _spinner.hidesWhenStopped = YES;
        [self addSubview:_spinner];
    }
    return _spinner;
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.spinner.constraints.count) return;
    
    // 圈圈
    CGFloat loadingCenterX = self.mj_w * 0.5;
    if (!self.isRefreshingTitleHidden) {
        loadingCenterX -= self.stateLabel.mj_textWith * 0.5 + self.labelLeftInset;
    }
    CGFloat loadingCenterY = self.mj_h * 0.5;
    self.spinner.center = CGPointMake(loadingCenterX, loadingCenterY);
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle) {
        [self.spinner stopAnimating];
    } else if (state == MJRefreshStateRefreshing) {
        [self.spinner startAnimating];
    }
}


@end
