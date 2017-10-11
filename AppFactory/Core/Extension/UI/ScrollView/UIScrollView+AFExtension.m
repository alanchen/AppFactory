//
//  UIScrollView+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIScrollView+AFExtension.h"
#import "UIView+AFExtension.h"
#import "LibsHeader.h"

@implementation UIScrollView(AFExtension)

-(void)layoutHorizontalSubViews:(NSArray *)subviews
{
    [self removeAllSubviews];
    
    float pageWidth = self.width;
    float pageCenterY = self.height/2;
    float pageCount = [subviews count];
    
    self.contentSize = CGSizeMake(pageCount*pageWidth, self.height);
    
    for(NSInteger index = 0  ; index < [subviews count]; index++){
        UIView *s = [subviews objectAtIndex:index];
        [self addSubview:s];
        float pageBeginX = pageWidth*index;
        s.centerY = pageCenterY;
        s.centerX = pageBeginX + pageWidth/2;
    }
}

@end
