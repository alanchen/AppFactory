//
//  PMCountryPickerViewController.m
//  PigMarket
//
//  Created by alan on 2015/7/8.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "AFCountryPickerViewController.h"
#import "AFCountryCell.h"
#import "AFBaseTableView.h"
#import "LibsHeader.h"

static NSString *kCellReuseIdentifier = @"kCellReuseIdentifier";

@interface AFCountryPickerViewController () <AFSearchBarViewDelegate>

@property (nonatomic,strong) AFBaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableList;
@property (nonatomic,strong) CountryCodePicker *picker;

@property (nonatomic,strong) UIColor *tintColor;
@property (nonatomic,strong) UIColor *textColor;

@end

@implementation AFCountryPickerViewController

#pragma mark - Public

-(void)setSelectTintColor:(UIColor *)color
{
    self.tintColor = color;
}

-(void)setCellTextColor:(UIColor *)color
{
    self.textColor = color;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"請選擇國碼";
    
    [self.view addSubview:self.tableView];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    self.tableView.tableHeaderView = header;
    [header addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(header).with.offset(-15);
        make.centerY.equalTo(header);
        make.height.equalTo(@30);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.left.equalTo(@0);
        make.top.equalTo(@0);
    }];
    
    self.tableList = self.picker.defaultCountries;
    [self.tableView reloadData];
    
    if(self.selectedCountryModel){
        [self scrollToSelectedCountryModel];
    }
}

#pragma mark - Private Methods

-(NSIndexPath *)indexPathOfTableList:(CountryModel *)country
{
    NSInteger index = 0;
    
    for(CountryModel *countryInList in self.tableList){
        if([country.name isEqual:countryInList.name])
            return [NSIndexPath indexPathForRow:index inSection:0];
        index++;
    }
    
    return nil;
}

-(void)scrollToSelectedCountryModel
{
    NSIndexPath *indexPath = [self indexPathOfTableList:self.selectedCountryModel];
    
    if(indexPath){
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionMiddle
                                      animated:YES];
    }
}

#pragma mark - AFSearchBarViewDelegate

- (void)searchView:(AFSearchBarView *)searchView textDidChange:(NSString *)searchText
{
    if([searchText length]==0){
        self.tableList = [self.picker defaultCountries];
    }
    else{
        self.tableList = [self.picker countriesBySearchTerm:searchText];
    }

    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.selectedCountryModel) {
        NSIndexPath *lastSelected = [self indexPathOfTableList:self.selectedCountryModel];
        if(lastSelected){
            self.selectedCountryModel = nil;
            [tableView reloadRowsAtIndexPaths:@[lastSelected]
                             withRowAnimation: UITableViewRowAnimationFade];
        }
    }
    
    CountryModel *country = [self.tableList objectAtIndex:indexPath.row];
    self.selectedCountryModel = country;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationFade];
    
    if([_delegate respondsToSelector:@selector(countryPickerDelegateDidSelected:picker:)]){
        [_delegate countryPickerDelegateDidSelected:self.selectedCountryModel picker:self];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchView.searchTextField resignFirstResponder];
}

#pragma mark - UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.tableList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFCountryCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    
    CountryModel *country = [self.tableList objectAtIndex:indexPath.row];
    cell.titleLabel.text =country.dialCode;
    cell.subtitleLabel.text = country.displayName;
    
    if([country.name isEqualToString:self.selectedCountryModel.name]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if(self.tintColor)
        cell.tintColor = self.tintColor;
    
    if(self.textColor){
        cell.titleLabel.textColor = self.textColor;
        cell.subtitleLabel.textColor  = self.textColor;
    }
    
    return cell;
}

#pragma mark - Setter & Getter

-(AFBaseTableView *)tableView
{
    if(!_tableView){
        _tableView = [[AFBaseTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        [_tableView setAllDelegateTo:self];
        [_tableView registerClass:[AFCountryCell class] forCellReuseIdentifier:kCellReuseIdentifier];
    }
    
    return _tableView;
}

-(AFSearchBarView *)searchView
{
    if(_searchView ==nil){
        _searchView = [AFSearchBarView view];
        _searchView.bgView.backgroundColor = [UIColor whiteColor];
        _searchView.delegate = self;
        _searchView.searchTextField.placeholder = @"搜尋";
    }

    return _searchView;
}

-(CountryCodePicker *)picker
{
    if(!_picker){
        _picker = [[CountryCodePicker alloc] init];
    }
    
    return _picker;
}


@end
