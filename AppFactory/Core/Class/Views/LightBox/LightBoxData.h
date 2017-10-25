//
//  LightBoxData.h
//  PigMarket
//
//  Created by alan on 2017/2/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppFactory.h"

typedef NS_ENUM(NSInteger, LightBoxAlign){
    LightBoxAlignAuto = 0,
    LightBoxAlignCenterX,
    LightBoxAlignCenterY,
    LightBoxAlignLeft,
    LightBoxAlignRight,
    LightBoxAlignTop,
    LightBoxAlignBottom
};

@interface LightBoxData : NSObject

@property (nonatomic)CGFloat margin; // default is 10
@property (nonatomic)LightBoxAlign xAlign;
@property (nonatomic)LightBoxAlign yAlign;
@property (nonatomic)CGSize contentViewSize;
@property (nonatomic)CGRect fromViewOnWindowFrame;

+(LightBoxData *)dataWithAlignX:(LightBoxAlign)xAlign
                         alignY:(LightBoxAlign)yAlign
                       viewSize:(CGSize)viewSize
                      fromFrame:(CGRect)frame;

-(CGPoint)startCenterPosition; // need calculate to get value
-(CGPoint)endCenterPosition;  // need calculate to get value

@end
