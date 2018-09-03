//
//  ViewController.m
//  AppFactory
//
//  Created by alan on 2017/9/26.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+AFRefresh.h"
#import "AFBaseTableCell.h"
#import "AFBaseTableView.h"
#import "UIActivityViewController+AFExtension.h"
#import "FeedbackHelper.h"
#import "ToastMessage.h"
#import "ImagePickerHelper.h"
#import "AFCountryPickerViewController.h"
#import "LibsHeader.h"

#import "RMessageHelper.h"
#import "FeedbackHelper.h"
#import "AnyPromise+AFExtension.h"

#import "LogMacros.h"
#import "TTTAttributedLabel+AFExtension.h"
#import "AFGhostButton.h"

#import "LightBoxWrapper.h"
#import "NotificationNumberView.h"

#import "ImagePickerHelper.h"
#import "AFButtonsView.h"

#import "WebControllerHelper.h"
#import "AFAppVersonHelper.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource,AFBaseTableViewDelegate>

@property (nonatomic,strong) AFBaseTableView *tableView;

@end

@implementation ViewController

-(void)reloadHeader
{
    [self.tableView endFooterRefreshing];
    [self bk_performBlock:^(id obj) {
        [self.tableView endHeaderRefreshing];
        [self.tableView hideSpinner];
         [self.tableView endFooterRefreshingWithNoMoreData];
//        [self.tableView reloadData];
//        if([list count] < self.loadMoreLimit){
//            [self.tableView endFooterRefreshingWithNoMoreData];
//        }else{
//            [self.tableView endFooterRefreshing];
//        }
        
    } afterDelay:1.0];
}

-(void)reloadFooter
{
    NSInteger page =  [self.navigationController.viewControllers indexOfObject:self];
    DLog(@"%zd",page);
    [self bk_performBlock:^(id obj) {
        [self.tableView endFooterRefreshingWithNoMoreData];
    } afterDelay:2.0];
}

-(void)test
{
    NOTIFICATION_POST(@"reload");
}

-(void)reload123
{
    NSInteger page =  [self.navigationController.viewControllers indexOfObject:self];
//    DLog(@"page %zd",page);
    
    if(page != 0)
        return;
    
      [self.tableView normalReloadLaunched];
//    self.tableView.mj_header.state = MJRefreshStateRefreshing;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Page 1";
    
    NOTIFICATION_ADD(self, @selector(reload123), @"reload");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(test)];
    
    self.tableView = [[AFBaseTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView setAllDelegateTo:self];
    [self.tableView registerClass:[AFBaseTableCell class] forCellReuseIdentifier:@"123"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView addRefreshingHeaderWithTarget:self action:@selector(reloadHeader) color:[UIColor redColor]];
    [self.tableView addLoadMoreFooterWithTarget:self action:@selector(reloadFooter) color:[UIColor blueColor]];

    [self.tableView setSpinnerColor:[UIColor redColor]];
    [self.tableView.refreshHeader setSpinnerColor:[UIColor redColor]];


    [self.tableView reloadData];
    
    NotificationNumberView *no  = [NotificationNumberView view];
    no.circleRadius = 10;
    no.number = 9;
    no.left = 100;
    no.top = 90;
    [self.view  addSubview:no];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HUD_SHOW;
    
    [self bk_performBlock:^(id obj) {
        HUD_DISMISS;
    } afterDelay:2.0];
    return;
//    [AFAppVersonHelper showAndCheckVersionWithTitle:nil message:nil goTitle:nil nextimeTitle:nil serverBuild:10 serverBuildForced:0 forcedUpdate:^{
//        
//    } optionalUpdate:^{
//        
//    } nextTimeUpdate:^{
//        
//    }];
    
//    ViewController *vc = [[ViewController alloc] init];
//    [self pushViewController:vc];
    
//    [self.tableView normalReloadLaunched];
    
//    ToastShow(@"123\nwefoiewf\nfiewhfohewiufu idhfpiuqewhf\n");
//    WKWebViewController *vc =
//    [WebControllerHelper showWebViewWithURLStr:@"http://ckclouds.com/api/meta/service" onViewController:self];
//    vc.cancelBlock = ^{
//        NSLog(@"ccccc");
//    };
    
//    [self.tableView endHeaderRefreshing];
//    [self.tableView endFooterRefreshingWithNoMoreData];
    id cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    ToastShow(INT2STR(indexPath.row));
    
//    [[ImagePickerHelper sharedInstance] showImagePickerOnViewController:self onButton:nil success:^(UIImage *image) {
//        DLog(@"ss");
//    } cancel:^{
//        DLog(@"cc");
//    }];
    
//    [RMessageHelper showOkay:@"123"];
//
//    UIButton *btn1 = [AFButtonsView createGhostButtonWithColor:[UIColor redColor] title:@"1" font:[UIFont systemFontOfSize:16] target:nil action:nil];
//    UIButton *btn2 = [AFButtonsView createButtonWithFillledColor:[UIColor blueColor] title:@"2" font:[UIFont systemFontOfSize:8] target:nil action:nil];
//
//   AFButtonsView *btnView = [AFButtonsView viewWithButtons:@[btn1,btn2]];
//    btnView.backgroundColor = [UIColor yellowColor];
//    btnView.top = 200;
//    btnView.left = 100;
//    btnView.width = 300;
//    [self.view addSubview:btnView];
    
//
    
//    if(indexPath.row ==0){
//        AFCountryPickerViewController *vc = [[AFCountryPickerViewController alloc] init];
//        [vc setCellTextColor:[UIColor grayColor]];
//        [vc setSelectTintColor:[UIColor yellowColor]];
//        [self pushViewController:vc];
//        
////        UIViewController *vc = [[UIViewController alloc] init];
////        vc.hidesBottomBarWhenPushed = YES;
////        [self.navigationController pushViewController:vc animated:YES];
////        self.hidesBottomBarWhenPushed = NO;
//
//    }else{
//        [WebControllerHelper showWebViewWithURLStr:@"http://ckclouds.com/api/meta/service" onViewController:self];
//    }

    
//    CTFeedbackViewController *vc = [FeedbackHelper showFeedbackWithAdditionalContent:@"hihihi" topics:@[@"12",@"34"] eMail:@"@123" onVC:self doneBlock:^(CTFeedbackViewController *vc) {
//        ToastShow(@"OKOKKOOK");
//    }];
//
//    vc.navigationController.navigationBar.tintColor = [UIColor redColor];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor redColor];

    if(indexPath.row ==0){
        [LightBoxWrapper sharedInstance].appearDuration  = 0.1;
        [LightBoxWrapper sharedInstance].disappearDuration  = 0.1;
        [LightBoxWrapper sharedInstance].shouldTapBackbgroundToDismiss = NO;
        [self bk_performBlock:^(id obj) {
            LightboxDismiss;
        } afterDelay:1.];
    }else if(indexPath.row ==1){
        [LightBoxWrapper sharedInstance].appearDuration  = 1.1;
        [LightBoxWrapper sharedInstance].disappearDuration  = 1.1;

    }
    LightboxShowFrom(view, cell);
    
//    [ImagePickerHelper checkAuthorizationWithMessage:@"try" cacnelText:@"ccc" openText:@"opop" doneBlock:^(BOOL success) {
//        ToastShow(INT2STR(success));
//    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFBaseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    cell.textLabel.text = INT2STR(arc4random()%999);
//    cell.cellHighLightStyle = CellHighLightStyleNone;
    
    return cell;
}


@end
