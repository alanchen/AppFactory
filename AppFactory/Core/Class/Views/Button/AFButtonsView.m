//
//  AFButtonsView.m
//  AppFactory
//
//  Created by alan on 2017/11/1.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFButtonsView.h"
#import "AppFactory.h"
#import "UIColor+AFExtension.h"
#import "BlocksKit.h"
#import <ViewUtils/ViewUtils.h>
#import <Masonry/Masonry.h>

@implementation AFButtonsView

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.horizontalSpace =  15.0;
        self.customViewHeight = 80;
        self.customButtonHeight = 50;
    }
    
    return self;
}

#pragma mark - Public Methods

+ (AFButtonsView *)viewWithButtons:(NSArray *)buttons
{
    AFButtonsView *v = [[self alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    v.buttons = buttons;
    return v;
}

+ (AFButtonsView *)viewWithButtons:(NSArray *)buttons buttonHeight:(CGFloat)buttonHeight
{
    AFButtonsView *v = [[self alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    v.customButtonHeight = buttonHeight;
    v.buttons = buttons;
    return v;
}

+ (AFButtonsView *)viewWithButton:(UIButton *)btn
{
    AFButtonsView *v = [[self alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    if(btn){ v.buttons = @[btn]; }
    return v;
}

+ (AFButtonsView *)viewWithButton:(UIButton *)btn buttonSize:(CGSize)size
{
    AFButtonsView *v = [[self alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    v.customButtonHeight = size.height;
    v.customButtonWidth = size.width;
    if(btn){ v.buttons = @[btn]; }
    return v;
}

#pragma mark - Setter & Getter

- (void)setButtons:(NSArray *)buttons
{
    if([buttons count]>2){
        DLog(@"We don't support  more than 3 buttons view.");
        return;
    }

    if( [buttons bk_any:^BOOL(id obj) {return ![obj isKindOfClass:[UIButton class]];}] ){
        DLog(@"Support UIButtons Only");
        return;
    }

    if([_buttons count]){
        [self removeAllSubviews];
        _buttons = nil;
    }

    _buttons = [buttons copy];

    for(UIView *v in _buttons){
        [self addSubview:v];
    }

    if([_buttons count]==0)
        self.height = 0;
    else
        self.height = self.customViewHeight;

    float buttonH = self.customButtonHeight;
    float buttonW = self.customButtonWidth;

    if([self.buttons count]==1) {
        [self.centerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(@(buttonH));

            if(buttonW){
                make.width.equalTo(@(buttonW));
                make.centerX.equalTo(self);
            }else{
                make.left.equalTo(@(self.horizontalSpace));
                make.right.equalTo(self).with.offset(-self.horizontalSpace);
            }
        }];

    }else if([self.buttons count]==2){

        [self.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.rightBtn.mas_left).with.offset(- self.horizontalSpace);
            make.left.equalTo(@( self.horizontalSpace));
            make.height.equalTo(@(buttonH));
        }];

        [self.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).with.offset(- self.horizontalSpace);
            make.height.equalTo(@(buttonH));
            make.width.equalTo(self.leftBtn);
        }];
    }
}

-(UIButton *)leftBtn
{
    UIButton *btn = [self.buttons firstObject];
    if([btn isKindOfClass:[UIButton class]])
        return btn;
    return nil;
}

-(UIButton *)rightBtn
{
    UIButton *btn = [self.buttons safelyObjectAtIndex:1];
    if([btn isKindOfClass:[UIButton class]])
        return btn;
    return nil;
}

-(UIButton *)centerBtn
{
    UIButton *btn = [self.buttons firstObject];
    if([btn isKindOfClass:[UIButton class]])
        return btn;
    return nil;
}

+(UIButton *)createButtonWithFillledColor:(UIColor *)color
                                    title:(NSString *)title
                                     font:(UIFont *)font
                                   target:(id)target
                                   action:(SEL)action
{
    UIButton *btn = [UIComponentFactory buttonWithFilledColor:color roundDiameter:50];
    [btn setNormalTitle:title];
    [btn setTitleFont:font];
    if(target && action) [btn addNormalTarget:target action:action];
    return btn;
}

+ (AFGhostButton *)createGhostButtonWithColor:(UIColor *)color
                                        title:(NSString *)title
                                         font:(UIFont *)font
                                       target:(id)target
                                       action:(SEL)action
{
    AFGhostButton *btn = [AFGhostButton ghostButtonWithColor:color font:font];
    btn.frame = CGRectMake(0, 0, 100, 50);
    [btn setNormalTitle:title];
    [btn setTitleFont:font];
    if(target && action) [btn addNormalTarget:target action:action];
    return btn;
    
}

@end
