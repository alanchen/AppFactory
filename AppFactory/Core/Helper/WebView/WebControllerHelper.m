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
    [navigationController setNavigationBarHidden:YES animated:NO];
    [vc presentViewController:navigationController animated:YES completion:nil];
    return;
    
}

@end
