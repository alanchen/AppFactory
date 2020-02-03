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

- (UIImage *)imageWithColor: (UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 32.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
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

-(void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    
    if (@available(iOS 13.0, *)) {
        UIImage *tintColorImage = [self imageWithColor:tintColor];
        UIImage *whiteImage = [self imageWithColor:[UIColor whiteColor]];

        self.segControl.selectedSegmentTintColor = tintColor;
        self.segControl.layer.borderColor = tintColor.CGColor;
        self.segControl.layer.borderWidth = 1;
        [self.segControl setBackgroundImage:whiteImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.segControl setBackgroundImage:tintColorImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

        [self.segControl setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor}
                                       forState:UIControlStateNormal];
        
        [self.segControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]  }
                                            forState:UIControlStateSelected];
        
        [self.segControl setDividerImage:tintColorImage
                     forLeftSegmentState:UIControlStateNormal
                       rightSegmentState:UIControlStateNormal
                              barMetrics:UIBarMetricsDefault];
        
    }
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
