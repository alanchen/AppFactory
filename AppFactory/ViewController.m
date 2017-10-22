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


@interface ViewController () <UITableViewDelegate,UITableViewDataSource,AFBaseTableViewDelegate>

@property (nonatomic,strong) AFBaseTableView *tableView;

@end

@implementation ViewController

-(void)test
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task =
    [manager GET:@"http://soundcloud.com/oembed?url=http%3A//soundcloud.com/forss/flickermood&format=json" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [task cancel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Page 1";
    
    self.tableView = [[AFBaseTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView setAllDelegateTo:self];
    [self.tableView registerClass:[AFBaseTableCell class] forCellReuseIdentifier:@"123"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView addRefreshingHeaderWithTarget:self action:@selector(test) color:[UIColor redColor]];
    
    [self.tableView reloadData];
    
    
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    
    label.numberOfLines = 0;
    label.font= [UIFont systemFontOfSize:20];
    
    [self.view addSubview:label];
    
    NSString *content = @"❈ 帳號綁定即表示您已經閱讀並同意我們的 使用者條款 / 隱私權政策\n\n❈ 我們不會主動為您發佈任何動態";
    NSString *policy = @"隱私權政策";
    NSString *useOfTerm = @"使用者條款";
    
    [label setText:content links:[NSSet setWithObjects:policy, useOfTerm, nil] linkColor:[UIColor redColor] linkFont:[UIFont systemFontOfSize:16]];
    [label sizeToFit];
    label.top = 100;
    label.left = 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView endHeaderRefreshing];
    
//    ToastShow(INT2STR(indexPath.row));
    
//    [[ImagePickerHelper sharedInstance] showImagePickerOnViewController:self onButton:nil success:^(UIImage *image) {
//        DLog(@"ss");
//    } cancel:^{
//        DLog(@"cc");
//    }];
    
//    [RMessageHelper showOkay:@"123"];
//
//    AFCountryPickerViewController *vc = [[AFCountryPickerViewController alloc] init];
//    [vc setCellTextColor:[UIColor grayColor]];
//    [vc setSelectTintColor:[UIColor yellowColor]];
//    [self pushViewController:vc];
    
    
    [FeedbackHelper showFeedbackWithAdditionalContent:nil topics:nil eMail:@"@123" onVC:self];
    
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
    cell.textLabel.text = @"123";
//    cell.cellHighLightStyle = CellHighLightStyleNone;
    
    return cell;
}


@end
