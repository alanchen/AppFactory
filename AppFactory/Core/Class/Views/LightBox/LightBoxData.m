//
//  PMLightBoxData.m
//  PigMarket
//
//  Created by alan on 2017/2/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "LightBoxData.h"

@implementation LightBoxData

#pragma mark - Private

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.margin = 10;
    }
    
    return self;
}

-(CGFloat)fromViewH{
    return self.fromViewOnWindowFrame.size.height;
}

-(CGFloat)fromViewW{
    return self.fromViewOnWindowFrame.size.width;
}

-(CGFloat)fromViewX{
    return self.fromViewOnWindowFrame.origin.x;
}

-(CGFloat)fromViewY{
    return self.fromViewOnWindowFrame.origin.y;
}

-(CGFloat)fromViewCenterY{
    return self.fromViewY + self.fromViewH/2;
}

-(CGFloat)fromViewCenterX{
    return self.fromViewX + self.fromViewW/2;
}

-(CGFloat)fromViewLeft{
    return self.fromViewX;
}

-(CGFloat)fromViewRight{
    return self.fromViewX + self.fromViewW;
}

-(CGFloat)fromViewTop{
    return self.fromViewY;
}

-(CGFloat)fromViewBottom{
    return self.fromViewY + self.fromViewH;
}

-(BOOL)isPositionVisible:(CGPoint)center
{
    CGFloat contentLeft = center.x - self.contentViewSize.width/2;
    CGFloat contentRight = center.x + self.contentViewSize.width/2;
    CGFloat contentTop = center.y - self.contentViewSize.height/2;
    CGFloat contentBottom = center.y + self.contentViewSize.height/2;
    
    if(contentLeft < 0 ||
       contentTop < 0 ||
       SCREENBOUNDS.size.width - contentRight < 0 ||
       SCREENBOUNDS.size.height - contentBottom < 0 )
    {
        return NO;
    }
    
    return YES;
}

#pragma mark - Public

+(LightBoxData *)dataWithAlignX:(LightBoxAlign)xAlign
                         alignY:(LightBoxAlign)yAlign
                       viewSize:(CGSize)viewSize
                      fromFrame:(CGRect)frame
{
    LightBoxData *data = [[LightBoxData alloc] init];
    data.xAlign = xAlign;
    data.yAlign = yAlign;
    data.contentViewSize = viewSize;
    data.fromViewOnWindowFrame = frame;

    return data;
}

-(CGPoint)startCenterPosition
{
    CGFloat centerX = 0;
    CGFloat centerY = 0;
    
    if(self.xAlign == LightBoxAlignCenterX){
        centerX = self.fromViewCenterX;
    }else if(self.xAlign == LightBoxAlignLeft){
        centerX = self.fromViewLeft ;
    }else if(self.xAlign == LightBoxAlignRight){
        centerX = self.fromViewRight;
    }else{
        centerX = SCREENBOUNDS.size.width/2;
    }
    
    if(self.yAlign ==  LightBoxAlignCenterY){
        centerY = self.fromViewCenterY;
    }else if(self.yAlign == LightBoxAlignTop){
        centerY = self.fromViewTop - self.margin;
    }else if(self.yAlign == LightBoxAlignBottom){
        centerY = self.fromViewBottom + self.margin;
    }else{
        BOOL isViewOnUpperArea = self.fromViewCenterY < SCREENBOUNDS.size.height/2;
        if(isViewOnUpperArea){
            centerY = self.fromViewBottom + self.margin;
        }else{
            centerY = self.fromViewTop - self.margin;
        }
    }
    
    if(![self isPositionVisible:self.endCenterPosition])
    {
        self.fromViewOnWindowFrame = CGRectMake(SCREENBOUNDS.size.width/2,  SCREENBOUNDS.size.height/2, 0, 0);
        self.xAlign = LightBoxAlignCenterX;
        self.yAlign = LightBoxAlignCenterY;
        centerX = self.fromViewCenterX;
        centerY = self.fromViewCenterY;
    }
    
    
    return CGPointMake(centerX, centerY);
}

-(CGPoint)endCenterPosition
{
    CGFloat centerX = 0;
    CGFloat centerY = 0;
    
    if(self.xAlign == LightBoxAlignCenterX){
        centerX = self.fromViewCenterX;
    }else if(self.xAlign == LightBoxAlignLeft){
        centerX = self.fromViewLeft + self.contentViewSize.width/2;
    }else if(self.xAlign == LightBoxAlignRight){
        centerX = self.fromViewRight - self.contentViewSize.width/2;
    }else{
        centerX = SCREENBOUNDS.size.width/2;
    }
    
    if(self.yAlign == LightBoxAlignCenterY){
        centerY = self.fromViewCenterY;
    }else if(self.yAlign == LightBoxAlignTop){
        centerY = self.fromViewTop - self.contentViewSize.height/2 - self.margin;
    }else if(self.yAlign == LightBoxAlignBottom){
        centerY = self.fromViewBottom + self.contentViewSize.height/2 + self.margin;
    }else{
        BOOL isViewOnUpperArea = self.fromViewCenterY < SCREENBOUNDS.size.height/2;
        if(isViewOnUpperArea){
            centerY = self.fromViewBottom + self.contentViewSize.height/2 + self.margin;
        }else{
            centerY = self.fromViewTop - self.contentViewSize.height/2 - self.margin;
        }
    }
    
    return CGPointMake(centerX, centerY);
}

@end


