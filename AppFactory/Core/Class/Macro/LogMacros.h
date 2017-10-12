//
//  LogMacros.h
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#ifdef DEBUG
//#   define DLog(fmt, ...) NSLog((@"%s (Line %d): " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#   define DLog(format, ...) printf("\n[%s] %s [Line %d] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#   define DLog(...)
#endif

#define RectLog(rect) DLog(@"rect %f %f %f %f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height)
