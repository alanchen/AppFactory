//
//  ToastMessage.m
//  AppFactory
//
//  Created by alan on 2017/10/6.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "ToastMessage.h"
#import <AudioToolbox/AudioServices.h>

@interface ToastMessage ()
@property (nonatomic,weak) MBProgressHUD *currentToast;
@property (nonatomic) float bottomOffsetPortrait;

@end

@implementation ToastMessage

+(ToastMessage *)sharedInstance
{
    static ToastMessage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ToastMessage alloc] init];
        sharedInstance.bottomOffsetPortrait = 90;
    });
    
    return sharedInstance;
}

+(void)setBottomOffsetPortrait:(float)offset
{
    [self sharedInstance].bottomOffsetPortrait = MAX(offset, 30);
}

+(void)show:(NSString *)str
{
    [self show:str window:[UIApplication sharedApplication].delegate.window];
}

+(void)show:(NSString *)str window:(UIWindow *)window
{
    if(!str)
        return;
    
    window = window ? window: [UIApplication sharedApplication].keyWindow;

    ToastMessage *toastInstance = [self sharedInstance];
    if(toastInstance.currentToast){
        [toastInstance.currentToast hideAnimated:NO];
        [toastInstance.currentToast removeFromSuperview];
        toastInstance.currentToast = nil;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:window];
    hud.margin = 12.0;
    [window addSubview:hud];
    hud.label.text = str;
    hud.label.font = [UIFont systemFontOfSize:16];
    hud.label.numberOfLines = 0;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
    hud.contentColor = [UIColor whiteColor];

    float offsetY = window.frame.size.height/2 - toastInstance.bottomOffsetPortrait - hud.margin;
    hud.offset = CGPointMake(hud.offset.x, offsetY);
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2.5];
    toastInstance.currentToast = hud;
}

+(void)showWithSound:(NSString *)str
{
    [self show:str];
    [self playSound];
}

+(void)playSound
{
//    SystemSoundID completeSound;
//    NSURL *audioPath = [[NSBundle mainBundle] URLForResource:@"cash" withExtension:@"caf"];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)audioPath, &completeSound);
//    AudioServicesPlaySystemSound (completeSound);
    
    // other sounds http://iphonedevwiki.net/index.php/AudioServices
    AudioServicesPlaySystemSound(1003);
}

@end
