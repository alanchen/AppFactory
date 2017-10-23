//
//  UIView+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(AFExtension)

@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat centerX;

- (UIViewController *)viewController;

- (void)maskOnSelfWithBlackAlpha:(float)alpha;

- (UITapGestureRecognizer *)tapBlock:(void (^)(void))block;

- (void)setBackgroundPattenImage:(NSString *)imgName;

- (void)removeAllSubviews;

- (void)setAllSubviewBgColor:(UIColor *)color;

- (id)findTheSubviewOfClass:(NSString *)className;

- (CAGradientLayer *)setGradientColorFrom:(UIColor *)color1 to:(UIColor *)color2;

@end
