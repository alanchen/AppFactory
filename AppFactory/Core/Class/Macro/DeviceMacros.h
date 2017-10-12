//
//  DeviceMacros.h
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#define SCREENBOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define STATUSBAR_FRAME [[UIApplication sharedApplication] statusBarFrame]
#define STATUSBAR_WIDTH [[UIApplication sharedApplication] statusBarFrame].size.width
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#define WIN_ROOT_VC [UIApplication sharedApplication].delegate.window.rootViewController
#define SHARED_APP [UIApplication sharedApplication]

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_PHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define INFO_APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define INFO_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define INFO_BUILD_NUMBER [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define PREFERRED_LANGUAGE [[NSLocale preferredLanguages] objectAtIndex:0]

#if TARGET_IPHONE_SIMULATOR
#define BUILD_ON_DEVICE 0
#else
#define BUILD_ON_DEVICE 1
#endif
