//
//  AppFactory.m
//  AppFactory
//
//  Created by alan on 2017/10/11.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppFactory.h"

@implementation AppFactory 

+(UIImage *)imageInTheBundleWithName:(NSString *)name
{
    NSBundle *imageBundle = [self bundle];
    UIImage* img = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:name ofType:@"png"]];
    return img;
}

+(NSBundle *)bundle
{
    NSBundle *bundle = [NSBundle bundleForClass:[AppFactory class]];
    NSURL *url = [bundle URLForResource:@"AppFactory" withExtension:@"bundle"];

    return  [NSBundle bundleWithURL:url];
}

@end
