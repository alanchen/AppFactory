//
//  UIScrollView+AFRefresh.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJRefresh/MJRefresh.h>
#import "AFRefreshHeader.h"
#import "AFRefreshFooter.h"

@interface UIScrollView(AFRefresh)

- (AFRefreshHeader *)refreshHeader;
- (AFRefreshFooter *)refreshFooter;

- (AFRefreshHeader *)addRefreshingHeaderWithTarget:(id)target action:(SEL)action color:(UIColor *)color;
- (AFRefreshFooter *)addLoadMoreFooterWithTarget:(id)target action:(SEL)action color:(UIColor *)color;

- (void)endHeaderRefreshing;
- (void)endFooterRefreshing;

- (void)hideSpinner;
- (void)showSpinner;
- (BOOL)isSpinnerAnimating;
- (void)setSpinnerColor:(UIColor *)color;

/**
 *    Need to make suer you loaded the tableview otherwise terrible thing happened.
 *    See how I call this for VoteList when Tapped the tabbar.
 *    I create a tableView in PMBaseTableVeiwController and make sure it after Viewdidload.
 *    So I can call [self.voteVC.tableView slientReloadLaunched];
 */

- (void)firstReloadLaunched;
- (void)normalReloadLaunched;
- (void)slientReloadLaunched;
- (void)loadMoreLaunched;

@end
