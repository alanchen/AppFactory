//
//  ScrollableSegmentedControl.m
//  PigMarket
//
//  Created by alan on 2015/6/30.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "ScrollableSegmentedControl.h"


@implementation ScrollableSegmentedControl

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        }
        
        [self addSubview:self.segControl];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
        self.segControl.clipsToBounds = YES;
        self.padding = 15.0;
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.segControl sizeToFit];
    CGRect segFrame = self.segControl.frame;
    CGRect selfFrame = self.frame;
    NSInteger segTopAlignCenterY = [@((selfFrame.size.height - segFrame.size.height)/2) integerValue];

    self.contentSize = CGSizeMake(segFrame.size.width + self.padding*2 , self.contentSize.height);
    segFrame.origin = CGPointMake(self.padding, segTopAlignCenterY);
    
    if(segFrame.size.width < selfFrame.size.width - 2*self.padding)
        segFrame.size = CGSizeMake(selfFrame.size.width - 2*self.padding, segFrame.size.height);
    
    self.segControl.frame = segFrame;
}

#pragma mark - Public Methods

-(void)setTitles:(NSArray *)titles
{
    [self.segControl removeAllSegments];
    
    for(NSInteger index = [titles count]-1 ; index>=0 ; index--){
        NSString *title  = [titles objectAtIndex:index];
        [self.segControl insertSegmentWithTitle:title atIndex:0 animated:NO];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


#pragma mark - Setter & Getter

-(UISegmentedControl *)segControl{
    if(!_segControl){
        _segControl = [[UISegmentedControl alloc] initWithFrame:CGRectZero];
    }
    
    return _segControl;
}

-(NSInteger)index{
    return _segControl.selectedSegmentIndex;
}

-(void)setIndex:(NSInteger)index{
    self.segControl.selectedSegmentIndex = index;
}


@end
