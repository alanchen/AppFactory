//
//  ScrollableSegmentedControl.h
//  PigMarket
//
//  Created by alan on 2015/6/30.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollableSegmentedControl : UIScrollView

@property (nonatomic,strong) UISegmentedControl *segControl;
@property (nonatomic) NSInteger index;
@property (nonatomic) CGFloat padding; // default is 15

-(void)setTitles:(NSArray *)titles;

@end
