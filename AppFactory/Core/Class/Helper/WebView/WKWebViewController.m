//
//  WKWebViewController.m
//  AppFactory
//
//  Created by alan on 2017/11/14.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "WKWebViewController.h"
#import <Masonry/Masonry.h>

@interface WKWebViewController()<WKNavigationDelegate>

@property (nonatomic,strong) NSURL *url ;

@end

@implementation WKWebViewController

+(WKWebViewController *)createWithURL:(NSURL *)url
{
    WKWebViewController *webVC = [[WKWebViewController alloc] init];
    webVC.url = url;
    return webVC;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                               target:self
                                                                                action:@selector(canelAction)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                target:self
                                                                                action:@selector(reloadAction)];
    
    self.navigationItem.rightBarButtonItem =reloadItem;
    
    self.webview = [[WKWebView alloc] initWithFrame:CGRectZero];
    self.webview.navigationDelegate = self;
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.webview loadRequest: [NSMutableURLRequest requestWithURL:self.url]];
}

-(void)canelAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)reloadAction
{
    [self.webview stopLoading];
    [self.webview reload];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [webView.scrollView setContentOffset:CGPointZero animated:NO];
}





@end
