//
//  AFBaseTableView.m
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFBaseTableView.h"
#import "LibsHeader.h"

@interface AFBaseTableView ()

@end

@implementation AFBaseTableView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        
        AFTableEmptyCaseView *emptyView = [[AFTableEmptyCaseView alloc] initWithFrame:CGRectMake(0, 0, 250 , 200)];
        self.emptyView = emptyView;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if([touch.view isKindOfClass:[UITableView class]]){
        if([self.afTableDelegate respondsToSelector:@selector(tableViewBackgroundTapped)]){
            [self.afTableDelegate tableViewBackgroundTapped];
        }
    }
}

#pragma mark - Public Methods

-(void)setAllDelegateTo:(id)delegate
{
    self.delegate = delegate;
    self.dataSource = delegate;
    self.afTableDelegate = delegate;
}

-(void)reloadData
{
    [super reloadData];
    
    if([self isSpinnerAnimating]){
        self.emptyView.hidden = YES;
    }else{
        self.emptyView.hidden = ![self shouldShowEmptyView];
    }
}

-(void)setDefaultEmptyText:(NSString *)text
{
    if([self.emptyView isKindOfClass:[AFTableEmptyCaseView class]]){
        ((AFTableEmptyCaseView *)self.emptyView).label.text = text;
    }
}

-(void)setDefaultEmptyTextColor:(UIColor *)color
{
    if([self.emptyView isKindOfClass:[AFTableEmptyCaseView class]]){
        ((AFTableEmptyCaseView *)self.emptyView).label.textColor = color;
    }
}

-(void)setDefaultEmptyTextFont:(UIFont *)font
{
    if([self.emptyView isKindOfClass:[AFTableEmptyCaseView class]]){
        ((AFTableEmptyCaseView *)self.emptyView).label.font = font;
    }
}

#pragma mark - Private Methods

-(BOOL)shouldShowEmptyView
{
    BOOL shouldShowEmptyView = NO;
    
    if([self.afTableDelegate respondsToSelector:@selector(tableViewEmptyCaseShouldDisplay)]) {
        shouldShowEmptyView = [self.afTableDelegate tableViewEmptyCaseShouldDisplay];}
    
    return shouldShowEmptyView;
}

#pragma mark - Setter

-(void)setEmptyView:(UIView *)emptyView
{
    if(_emptyView){
        [_emptyView removeFromSuperview];
        _emptyView = nil;
    }
    
    _emptyView = emptyView;
    _emptyView.hidden = YES;
    [self addSubview:emptyView];
    
    @weakify(self);
    [RACObserve(self, mj_header.state) subscribeNext:^(NSNumber *x){
        @strongify(self);
        MJRefreshState state = (MJRefreshState)[x integerValue];
        if(state == MJRefreshStateIdle)
            self.emptyView.hidden = ![self shouldShowEmptyView];
    }];
    
    [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.width.equalTo(@(emptyView.width));
        make.height.equalTo(@(emptyView.height));
    }];
}

@end
