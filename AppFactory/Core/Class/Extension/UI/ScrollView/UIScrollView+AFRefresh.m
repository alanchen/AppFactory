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

- (AFRefreshlHeader *)refreshlHeader
{
    return (AFRefreshlHeader *)self.mj_header;
}

- (AFRefreshlHeader *)addRefreshingHeaderWithTarget:(id)target action:(SEL)action color:(UIColor *)color
{
    self.mj_header = [AFRefreshlHeader headerWithRefreshingTarget:target
                                                 refreshingAction:action
                                                      reloadImage:AF_BUNDLE_IMAGE(@"table-reload-arrow")];
    [(AFRefreshlHeader *)self.mj_header setArrowTintColor:color];
    return (AFRefreshlHeader *)self.mj_header;
}

- (MJRefreshFooter *)addLoadMoreFooterWithTarget:(id)target action:(SEL)action color:(UIColor *)color
{
    return nil;
}

- (void)endHeaderRefreshing
{
    [self.mj_header endRefreshing];
}

- (void)endFooterRefreshing
{
    [self.mj_footer endRefreshing];
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
    self.mj_footer.hidden = YES;
}

- (void)normalReloadLaunched
{
    if(self.mj_header.state == MJRefreshStateRefreshing)
        return;
    
    self.mj_header.state = MJRefreshStateRefreshing;
    self.mj_footer.hidden = YES;
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
    self.mj_footer.hidden = YES;
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
