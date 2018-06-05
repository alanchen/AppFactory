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
@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation WKWebViewController

+(WKWebViewController *)createWithURL:(NSURL *)url
{
    WKWebViewController *webVC = [[WKWebViewController alloc] init];
    if(!url){url = [NSURL URLWithString:@"about:blank"];}
    webVC.url = url;
    return webVC;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                               target:self
                                                                                action:@selector(canelAction)];
    
    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                target:self
                                                                                action:@selector(reloadAction)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    self.navigationItem.rightBarButtonItem = reloadItem;
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.trackTintColor = [UIColor clearColor];
    self.progressView.progressTintColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
    [self.progressView setProgress:0.1 animated:YES];
    [self.webView addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
        make.width.equalTo(self.webView);
        make.height.equalTo(@2);
    }];
    
    [self.webView loadRequest: [NSMutableURLRequest requestWithURL:self.url]];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - Actions

-(void)canelAction
{
    if(self.cancelBlock) self.cancelBlock();
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)reloadAction
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [self.webView loadRequest: [NSMutableURLRequest requestWithURL:self.url]];
}

#pragma mark - Observer

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([object isEqual:self.webView] && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.progressView setProgress:newprogress animated:YES];
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.8 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                weakSelf.progressView.hidden = YES;
                [weakSelf.progressView setProgress:0 animated:NO];
            });
        } else { // loading
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    } else if ([object isEqual:self.webView] && [keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    } else { 
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
