//
//  UIButton+ExpandHitArea.m
//  AppFactory
//
//  Created by alan on 2017/9/29.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIButton+ExpandHitArea.h"
#import <objc/runtime.h>

void YTSwizzleMethod(Class cls, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation UIButton(ExpandHitArea)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        YTSwizzleMethod([self class], @selector(pointInside:withEvent:), @selector(yt_pointInside:withEvent:));
    });
}

- (UIEdgeInsets)hitTestEdgeInsets {
    NSValue* value = objc_getAssociatedObject(self, _cmd);
    UIEdgeInsets insets = UIEdgeInsetsZero;
    [value getValue:&insets];
    return insets;
}

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue* value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, @selector(hitTestEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)yt_pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    UIEdgeInsets insets = self.hitTestEdgeInsets;
    if (UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero)) {
        return [self yt_pointInside:point withEvent:event];
    } else {
        CGRect hitBounds = UIEdgeInsetsInsetRect(self.bounds, insets);
        return CGRectContainsPoint(hitBounds, point);
    }
}

#pragma mark -

-(void)setExtendTappingAreaInsets:(UIEdgeInsets)edge
{
    self.hitTestEdgeInsets = UIEdgeInsetsMake( -edge.top,-edge.left,-edge.bottom,-edge.right);
}

-(void)setExtend20TappingArea
{
    [self setExtendTappingAreaInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
}


@end
