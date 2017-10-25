//
//  PMLightBoxWrapper.m
//  PigMarket
//
//  Created by alan on 2017/2/7.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "LightBoxWrapper.h"
#import <pop/POP.h>
#import <BlocksKit/BlocksKit+UIKit.h>
#import <ViewUtils/ViewUtils.h>

@interface LightBoxWrapper() <UIGestureRecognizerDelegate>

@property (nonatomic,weak) UIView *contentView;
@property (nonatomic) BOOL isTouchBlocked;
@property (nonatomic,strong) LightBoxData *data;

@end

@implementation LightBoxWrapper

#pragma mark - Life Cycle

+(LightBoxWrapper *)sharedInstance
{
    static LightBoxWrapper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LightBoxWrapper alloc] initWithFrame:CGRectZero];
    });
    
    return sharedInstance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.size = SCREENBOUNDS.size;
        self.bgAlpha = 0.3;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            if(state != UIGestureRecognizerStateEnded){ return ;}
            CGPoint point = [sender locationInView:self];
            UIView *viewTouched = [self hitTest:point withEvent:nil];
            if (viewTouched == self && !self.isTouchBlocked && self.shouldTapBackbgroundToDismiss) {
                [self dismiss];
            }
        }];
        tap.delegate = self;
        
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

#pragma mark UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - POPAnimationDelegate

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
    if([anim.name isEqualToString:@"DismissAnimation"] && finished){
        [self reset];
    }else if([anim.name isEqualToString:@"ShowAnimation"] && finished){
        self.isTouchBlocked = NO;
    }
}

#pragma mark - Public

- (void)showContentView:(UIView *)contentView
               fromView:(UIView *)fromView
        horizontalAlign:(LightBoxAlign)h
          verticalAlign:(LightBoxAlign)v
{
    if([fromView viewOrAnySuperviewIsKindOfClass:[self class]])
        fromView = nil;
    
    [self reset];
    
    self.contentView = contentView;
    [self addSubview:self.contentView];
    [SHARED_APP.delegate.window addSubview:self];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    self.contentView.alpha = 0;
    
    self.data.contentViewSize = contentView.size;
    if(!fromView){
        self.data.fromViewOnWindowFrame = CGRectMake(SCREENBOUNDS.size.width/2,  SCREENBOUNDS.size.height/2, 0, 0);
        self.data.yAlign = LightBoxAlignCenterY;
        self.data.xAlign = LightBoxAlignCenterX;
    }else{
        self.data.fromViewOnWindowFrame = [fromView convertRect:fromView.bounds toView:nil];
        self.data.yAlign = v;
        self.data.xAlign = h;
    }
    
    [self applyAppearingAnimationTo:contentView startPoint:self.data.startCenterPosition endPoint:self.data.endCenterPosition];
}

- (void)showContentView:(UIView *)contentView
               fromView:(UIView *)fromView
{
    [self showContentView:contentView fromView:fromView horizontalAlign:LightBoxAlignCenterX verticalAlign:LightBoxAlignCenterY];
}

-(void)updateLayout
{
    if(!self.contentView){
        return;
    }

    self.data.contentViewSize = self.contentView.size;
    CGPoint position = [self.data endCenterPosition];
    self.contentView.x = position.x;
    self.contentView.y = position.y;
}

- (void)dismiss
{
    self.isTouchBlocked = YES;
    [self applyDisappearingAnimationTo:self.contentView startPoint:self.data.endCenterPosition endPoint:self.data.startCenterPosition];
}

#pragma mark - Private

-(void)reset
{
    if([[self pop_animationKeys] count]>0)
        [self pop_removeAllAnimations];
    
    if([[self.contentView pop_animationKeys] count]>0)
        [self.contentView pop_removeAllAnimations];
    
    if([[self.contentView.layer pop_animationKeys] count]>0)
        [self.contentView.layer pop_removeAllAnimations];
    
    if([[self subviews] count]>0)
        [self removeAllSubviews];
    
    if(self.superview)
        [self removeFromSuperview];
    
    self.contentView = nil;
    self.isTouchBlocked = YES;
    self.data = [[LightBoxData alloc] init];
    self.shouldTapBackbgroundToDismiss = YES;
}

#pragma mark - Animation

-(void)applyDisappearingAnimationTo:(UIView *)contentView startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CGFloat duration = 0.3;
    
    POPBasicAnimation *bgAnimation = [POPBasicAnimation animation];
    bgAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewBackgroundColor];
    bgAnimation.fromValue= [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgAlpha];
    bgAnimation.toValue= [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    bgAnimation.duration = duration;
    bgAnimation.delegate = self;
    bgAnimation.name  = @"DismissAnimation";
    bgAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self pop_addAnimation:bgAnimation forKey:@"dismiss1"];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(0.8);
    opacityAnimation.toValue = @(0.1);
    opacityAnimation.duration = duration;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [contentView.layer pop_addAnimation:opacityAnimation forKey:@"dismiss2"];
    
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
    positionAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
    positionAnimation.duration = duration;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [contentView.layer pop_addAnimation:positionAnimation forKey:@"dismiss3"];
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.fromValue  = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleAnimation.toValue  = [NSValue valueWithCGSize:CGSizeMake(0.0f, 0.0f)];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation.duration = duration;
    [contentView.layer pop_addAnimation:scaleAnimation forKey:@"dismiss4"];
}

-(void)applyAppearingAnimationTo:(UIView *)contentView startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CGFloat duration = 0.3;

    POPBasicAnimation *bgAnimation = [POPBasicAnimation animation];
    bgAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewBackgroundColor];
    bgAnimation.fromValue= [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    bgAnimation.toValue= [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgAlpha];
    bgAnimation.duration = duration;
    bgAnimation.name  = @"ShowAnimation";
    bgAnimation.delegate = self;
    bgAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self pop_addAnimation:bgAnimation forKey:@"evt1"];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @0;
    opacityAnimation.toValue = @1;
    opacityAnimation.duration = duration;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [contentView.layer pop_addAnimation:opacityAnimation forKey:@"evt2"];
    
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
    positionAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
    positionAnimation.duration = duration;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [contentView.layer pop_addAnimation:positionAnimation forKey:@"evt3"];
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.fromValue  = [NSValue valueWithCGSize:CGSizeMake(0.0f, 0.0f)];
    scaleAnimation.toValue  = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scaleAnimation.duration = duration;
    [contentView.layer pop_addAnimation:scaleAnimation forKey:@"evt4"];
}

@end
