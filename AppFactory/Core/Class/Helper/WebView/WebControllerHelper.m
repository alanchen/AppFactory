//
//  WebControllerHelper.m
//  AppFactory
//
//  Created by alan on 2017/10/6.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "WebControllerHelper.h"
#import <SafariServices/SafariServices.h>
#import "NSURL+AFExtension.h"
#import "DeviceMacros.h"

@implementation WebControllerHelper

+(void)showWithURLStr:(NSString *)urlStr on:(UIViewController *)vc
{
    NSURL *url = [NSURL urlByValidationWithString:urlStr];
    [self showWithURL:url onViewController:vc];
}

+(void)showWithURL:(NSURL *)url on:(UIViewController *)vc;
{
    NSString *urlStr = url.absoluteString;
    url = [NSURL urlByValidationWithString:urlStr];
    [self showWithURL:url onViewController:vc ];
}

+(void)showWithURL:(NSURL *)url onViewController:(UIViewController *)vc
{
    if(!vc)
        vc = WIN_ROOT_VC;
    
    url = [url urlByAddingValidHTTPSchemeIfNeed];
    
    SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:url];
    safariViewController.delegate = nil;
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:safariViewController];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    [navigationController setNavigationBarHidden:YES animated:NO];
    [vc presentViewController:navigationController animated:YES completion:nil];
}

+(WKWebViewController *)showWebViewWithURLStr:(NSString *)urlStr onViewController:(UIViewController *)vc
{
     NSURL *url = [NSURL urlByValidationWithString:urlStr];
    return [self showWebViewWithURL:url onViewController:vc];
}

+(WKWebViewController *)showWebViewWithURL:(NSURL *)url onViewController:(UIViewController *)vc
{
    if(!vc)
        vc = WIN_ROOT_VC;
    
    url = [url urlByAddingValidHTTPSchemeIfNeed];
    
    WKWebViewController *webVC = [WKWebViewController createWithURL:url];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:webVC];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:navigationController animated:YES completion:nil];
    return webVC;
}


@end
