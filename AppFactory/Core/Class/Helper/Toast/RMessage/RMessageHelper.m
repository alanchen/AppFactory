//
//  RMessageHelper.m
//  PigMarket
//
//  Created by alan on 2017/3/14.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "RMessageHelper.h"
#import "RMessageView.h"
#import "AppFactory.h"

static double const kRMessageDuration = 2.0f;

@implementation RMessageHelper

#pragma mark - Private

+(void)showWithTitle:(NSString *)title customName:(NSString *)name duration:(double)duration
{
    static BOOL setupOnce = NO;
    
    if(!setupOnce){
        NSBundle *bundle = [AppFactory bundle];
        [RMessage addDesignsFromFileWithName:@"AlternativeDesigns" inBundle:bundle];
        [[RMessageView appearance] setTitleAlignment:NSTextAlignmentCenter];
        setupOnce = YES;
    }
    
    BOOL isEnable = [UIView areAnimationsEnabled];
    
    if([RMessage isNotificationActive]){
        [UIView setAnimationsEnabled:YES];
        [RMessage dismissActiveNotificationWithCompletion:^{
            [RMessage showNotificationWithTitle:title subtitle:nil type:RMessageTypeCustom customTypeName:name duration:duration callback:^{
                [UIView setAnimationsEnabled:isEnable];
            }];
        }];
    }else{
        [UIView setAnimationsEnabled:YES];
        [RMessage showNotificationWithTitle:title subtitle:nil type:RMessageTypeCustom customTypeName:name duration:duration callback:^{
            [UIView setAnimationsEnabled:isEnable];
        }];
    }
}

#pragma mark - Public

+(void)setViewController:(UIViewController *)defaultViewController
{
    [RMessage setDefaultViewController:defaultViewController];
}

+(void)showError:(NSString *)title
{
    [self showWithTitle:title customName:@"error" duration:kRMessageDuration];
}

+(void)showWarning:(NSString *)title
{
    [self showWithTitle:title customName:@"warning" duration:kRMessageDuration];
}

+(void)showOkay:(NSString *)title
{
    [self showWithTitle:title customName:@"success" duration:kRMessageDuration];
}

+(void)showMessage:(NSString *)title
{
    [self showWithTitle:title customName:@"message" duration:kRMessageDuration];
}

+(void)dismiss
{
    [RMessage dismissActiveNotification];
}

@end

