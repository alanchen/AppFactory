//
//  AFBaseTableViewController.h
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#import "AFBaseTableView.h"
#import "AFBaseViewController.h"

@protocol AFBaseTableViewControllerDelegate <NSObject>
@optional
-(BOOL)shouldAddTableConstraintAtViewDidLoad;
@end

@interface AFBaseTableViewController : AFBaseViewController <AFBaseTableViewDelegate,AFBaseViewControllerDelegate>

@property (nonatomic,strong) AFBaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray *itemList;
@property (nonatomic) NSInteger loadMoreLimit;

- (void)launchFirstReload;
- (void)reloadLaunched;

- (void)addRefreshingHeaderWithTarget:(id)target action:(SEL)action;
- (void)addLoadMoreFooterWithTarget:(id)target action:(SEL)action;

- (void)beginOfReloadWithApi:(NSURLSessionTask* (^)(void))api;
- (void)endOfReloadWithList:(NSArray *)list;
- (void)beginOfLoadMore:(NSURLSessionTask* (^)(void))api;
- (void)endOfLoadMoreWithList:(NSArray *)list;

- (void)cancelTask;

@end
