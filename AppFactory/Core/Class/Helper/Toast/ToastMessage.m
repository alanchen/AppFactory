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
@property (nonatomic,weak) Toast *currentToast;
@end

@implementation ToastMessage

+(ToastMessage *)sharedInstance
{
    static ToastMessage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ToastMessage alloc] init];
        ToastView.appearance.bottomOffsetPortrait = 90;
    });
    
    return sharedInstance;
}

+(void)setBottomOffsetPortrait:(CGFloat)offset
{
    ToastView.appearance.bottomOffsetPortrait = MAX(offset, 30);
}

+(void)show:(NSString *)str
{
    if(!str)
        return;
    
    [[self sharedInstance].currentToast cancel];
    [self sharedInstance].currentToast = nil;
    
    ToastView.appearance.font = [UIFont systemFontOfSize:16];
    Toast *t = [[Toast alloc] initWithText:str delay:0.0 duration:3.0];
    [self sharedInstance].currentToast = t;
    [t show];
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
