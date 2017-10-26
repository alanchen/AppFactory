//
//  AFBaseTableViewController.m
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFBaseTableViewController.h"
#import "LibsHeader.h"
#import "NSObject+AFExtension.h"
#import "NSMutableArray+AFExtension.h"

@interface  AFBaseTableViewController()
@property (nonatomic,weak) NSURLSessionTask *task;
@end

@implementation AFBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.loadMoreLimit = 50;
    
    if([self shouldAddTableConstraintAtViewDidLoad]){
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.view);
            make.left.equalTo(@0);
            make.top.equalTo(@0);
        }];
    }
}

#pragma mark -PMBaseTableViewControllerDelegate

-(BOOL)shouldAddTableConstraintAtViewDidLoad{
    return YES;
}

#pragma mark - Public Method

- (void)launchFirstReload
{
    [self.tableView firstReloadLaunched];
}

- (void)reloadLaunched
{
    [self.tableView normalReloadLaunched];
}

- (void)addRefreshingHeaderWithTarget:(id)target action:(SEL)action
{
    [self.tableView addRefreshingHeaderWithTarget:target action:action color:nil];
}

- (void)addLoadMoreFooterWithTarget:(id)target action:(SEL)action
{
    [self.tableView addLoadMoreFooterWithTarget:target action:action color:nil];
}

- (void)beginOfReloadWithApi:(NSURLSessionTask* (^)(void))api
{
    self.task = api();
    self.tableView.mj_footer.hidden = YES;
}

-(void)endOfReloadWithList:(NSMutableArray *)list
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView hideSpinner];
    
    self.itemList = [NSMutableArray array];
    [self.itemList safelyAddObjectsFromArray:list];
    
    [self.tableView reloadData];
    self.tableView.mj_footer.hidden = [list count] < self.loadMoreLimit;
}

- (void)beginOfLoadMore:(NSURLSessionTask* (^)(void))api
{
    self.task = api();
}

-(void)endOfLoadMoreWithList:(NSArray *)list
{
    [self.tableView.mj_footer endRefreshing];
    [self.itemList safelyAddObjectsFromArray:list];
    [self.tableView reloadData];
    self.tableView.mj_footer.hidden = [list count] < self.loadMoreLimit;
}

- (void)cancelTask
{
    [self.task cancel];
    self.task = nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.itemList count];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

#pragma mark - BaseTableViewDelegate

- (BOOL) tableViewEmptyCaseShouldDisplay
{
    return  [self.itemList count]?NO:YES;
}

#pragma mark - Setter & Getter

-(void)setTask:(NSURLSessionTask *)task
{
    if(!task){
        return;
    }

    [_task cancel];
    _task = task;

    __weak NSURLSessionTask *weakTask = _task;
    @weakify(self);
    [RACObserve(_task,state) subscribeNext:^(id x) {
        @strongify(self);
        NSURLSessionTaskState state = [x integerValue];
        if(state == NSURLSessionTaskStateCompleted){
            if(self.task == weakTask)
                self.task = nil;
        }
    }];
}

-(AFBaseTableView *)tableView
{
    if(!self.isViewLoaded)
        return nil;
    
    if(!_tableView){
        _tableView = [[AFBaseTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        [_tableView setAllDelegateTo:self];
    }
    
    return _tableView;
}

-(NSMutableArray *)itemList
{
    if(!_itemList){
        _itemList = [NSMutableArray array];
    }
    
    return _itemList;
}
@end
