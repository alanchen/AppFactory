//
//  UIButton+ExpandHitArea.h
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton(ExpandHitArea)

@property (nonatomic) UIEdgeInsets hitTestEdgeInsets;

-(void)setExtendTappingAreaInsets:(UIEdgeInsets)edge; // ig: UIEdgeInsetsMake(20, 20, 20, 20)

-(void)setExtend20TappingArea;

@end
