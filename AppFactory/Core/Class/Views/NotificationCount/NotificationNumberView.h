//
//  PMNotificationNumberView.h
//  PigMarket
//
//  Created by alan on 2015/8/4.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationNumberView : UIView

@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic) float circleRadius; // default is 8, so the height is 16
@property (nonatomic) BOOL hideWhenZero; // default is YES
@property (nonatomic) NSInteger number; // default is 0

+(NotificationNumberView *)view;

-(void)setColor:(UIColor *)color;

-(void)showN;

@end
