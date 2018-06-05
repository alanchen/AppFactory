//
//  WKWebViewController.h
//  AppFactory
//
//  Created by alan on 2017/11/14.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface WKWebViewController : UIViewController

@property (nonatomic,strong) WKWebView *webView;

+(WKWebViewController *)createWithURL:(NSURL *)url;

@property (nonatomic,copy) void (^cancelBlock)();

@end
