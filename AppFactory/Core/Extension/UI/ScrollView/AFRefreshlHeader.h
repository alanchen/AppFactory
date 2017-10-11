//
//  AFRefreshlHeader.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefreshStateHeader.h"

@interface AFRefreshlHeader : MJRefreshStateHeader

@property (weak, nonatomic, readonly) UIImageView *arrowView;
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action reloadImage:(UIImage *)image;
- (void)setArrowTintColor:(UIColor *)tintColor;

@end

