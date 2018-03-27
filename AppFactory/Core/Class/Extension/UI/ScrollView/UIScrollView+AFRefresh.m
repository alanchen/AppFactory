//
//  UIScrollView+AFRefresh.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIScrollView+AFRefresh.h"
#import "AppFactory.h"
#import "LibsHeader.h"

@implementation UIScrollView(AFRefresh)

- (AFRefreshHeader *)refreshHeader
{
    return (AFRefreshHeader *)self.mj_header;
}

- (AFRefreshFooter *)refreshFooter
{
    return (AFRefreshFooter *)self.mj_footer;
}

- (AFRefreshHeader *)addRefreshingHeaderWithTarget:(id)target action:(SEL)action color:(UIColor *)color
{
    self.mj_header = [AFRefreshHeader headerWithRefreshingTarget:target
                                                refreshingAction:action
                                                     reloadImage:AF_BUNDLE_IMAGE(@"table-reload-arrow")];
    [(AFRefreshHeader *)self.mj_header setArrowTintColor:color];
    return (AFRefreshHeader *)self.mj_header;
}

- (MJRefreshFooter *)addLoadMoreFooterWithTarget:(id)target action:(SEL)action color:(UIColor *)color
{
    AFRefreshFooter *footer = [AFRefreshFooter footerWithRefreshingTarget:target refreshingAction:action];
    footer.refreshingTitleHidden = YES;
    footer.mj_h = 60;
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"" forState:MJRefreshStatePulling];
    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"" forState:MJRefreshStateWillRefresh];
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];

    if(color){
        footer.spinner.color = color;
    }
    [footer resetNoMoreData];
    [footer endRefreshingWithNoMoreData];
    footer.hidden = YES;
    
    self.mj_footer = footer;
    return self.mj_footer;
}

- (void)endHeaderRefreshing
{
    [self.mj_header endRefreshing];
}

- (void)endFooterRefreshing
{
    [self.mj_footer endRefreshing];
    self.mj_footer.hidden = NO;
}

- (void)endFooterRefreshingWithNoMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
    self.mj_footer.hidden = YES;
}

#pragma mark -

- (void)firstReloadLaunched
{
    id target = self.mj_header.refreshingTarget;
    SEL selector = self.mj_header.refreshingAction;
    
    if(!target || !selector)
        return;
    
    PERFORM_SELECTOR(target,selector);
    
    [self showSpinner];
    [self endFooterRefreshingWithNoMoreData];
}

- (void)normalReloadLaunched
{
    if(self.mj_header.state == MJRefreshStateRefreshing)
        return;
    
    self.mj_header.state = MJRefreshStateRefreshing;
    [self endFooterRefreshingWithNoMoreData];
}

- (void)slientReloadLaunched
{
    if(self.mj_header.state == MJRefreshStateRefreshing)
        return;
    
    id target = self.mj_header.refreshingTarget;
    SEL selector = self.mj_header.refreshingAction;
    
    if(!target || !selector)
        return;
    
    PERFORM_SELECTOR(target,selector);
    
    [self hideSpinner];
    [self endFooterRefreshingWithNoMoreData];
}

- (void)loadMoreLaunched
{
    if(self.mj_footer.state == MJRefreshStateRefreshing)
        return;
    
    self.mj_footer.hidden = NO;
    self.mj_footer.state = MJRefreshStateRefreshing;
}

#pragma mark - spinner

-(UIActivityIndicatorView *)loadingSpinner
{
    return self.af_spinner;
}

-(void)hideSpinner
{
    [self.loadingSpinner stopAnimating];
    self.loadingSpinner.hidden = YES;
}

-(void)showSpinner
{
    [self.loadingSpinner startAnimating];
    self.loadingSpinner.hidden = NO;
}

- (BOOL)isSpinnerAnimating
{
    return  [self.loadingSpinner isAnimating];
}

- (void)setSpinnerColor:(UIColor *)color
{
    self.loadingSpinner.color = color;
}

@end
