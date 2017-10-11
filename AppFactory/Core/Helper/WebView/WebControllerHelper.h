//
//  WebControllerHelper.h
//  AppFactory
//
//  Created by alan on 2017/10/6.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebControllerHelper : NSObject

+(void)showWithURLStr:(NSString *)urlStr on:(UIViewController *)vc;
+(void)showWithURL:(NSURL *)url on:(UIViewController *)vc;

@end
