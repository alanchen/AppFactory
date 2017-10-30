//
//  UIView+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIView+AFExtension.h"
#import "LibsHeader.h"

@interface UIView(TapGesture)
@property (nonatomic,weak) UITapGestureRecognizer *tapGesture;
@end

@implementation UIView(TapGesture)
SYNTHESIZE_ASC_OBJ(tapGesture, setTapGesture);
@end

@implementation UIView(AFExtension)

- (CGFloat)centerY
{
    return self.top + self.height/2;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGRect frame = self.frame;
    frame.origin.y = centerY - frame.size.height/2;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.left + self.width/2;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGRect frame = self.frame;
    frame.origin.x = centerX - frame.size.width/2;
    self.frame = frame;
}

#pragma mark -

- (UIViewController *)viewController
{
    UIResponder *responder = self;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return (UIViewController *)responder;
}

- (void)maskOnSelfWithBlackAlpha:(float)alpha
{
    UIView *mask = [[UIView alloc] initWithFrame:CGRectZero];
    mask.userInteractionEnabled = NO;
    mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    [self addSubview:mask];
    
    [mask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(self);
        make.height.equalTo(self);
    }];
}

- (UITapGestureRecognizer *)tapBlock:(void (^)(void))block
{
    self.userInteractionEnabled = YES;
    if(self.tapGesture) return nil;
    
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {if(block) block();}];
    [self addGestureRecognizer:g];
    self.tapGesture = g;
    return g;
}

- (void)setBackgroundPattenImage:(NSString *)imgName
{
    if(!imgName)
        return;
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imgName]];
}

- (void)removeAllSubviews
{
    for(UIView *subview in [self subviews])
        [subview removeFromSuperview];
}

- (void)setAllSubviewBgColor:(UIColor *)color
{
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *subviews = [subview subviews];
        if([subviews count]){
            [subview setAllSubviewBgColor:color];
        }else{
            subview.backgroundColor = color;
        }
    }];
}

- (id)findTheSubviewOfClass:(Class)targetClass
{
    __block  id target;
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
        if([subview isKindOfClass:targetClass]){
            target = subview;
            *stop = YES;
        }else{
            target = [subview findTheSubviewOfClass:targetClass];
        }
    }];
    
    return target;
}

- (id)findTheSuperviewOfClass:(Class)targetClass
{
    __block UIView *target = self.superview;
    while (target) {
        if([target isKindOfClass:targetClass]){
            return target ;
        }else{
            target = self.superview;
        }
    }
    
    return nil;
}

- (CAGradientLayer *)setGradientColorFrom:(UIColor *)color1 to:(UIColor *)color2
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, self.width, self.height);
    gradient.colors = @[(id)color1.CGColor, (id)color2.CGColor];
    [self.layer insertSublayer:gradient atIndex:0];
    return gradient;
}

@end
