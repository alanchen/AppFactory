//
//  AFBaseTableView.h
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFTableEmptyCaseView.h"
#import "UIScrollView+AFRefresh.h"

@protocol AFBaseTableViewDelegate <NSObject>
@optional
- (BOOL) tableViewEmptyCaseShouldDisplay;
- (void) tableViewBackgroundTapped;
@end

@interface AFBaseTableView : UITableView

@property (nonatomic,weak) id <AFBaseTableViewDelegate> afTableDelegate;
@property (nonatomic,strong) UIView *emptyView;

-(void)setAllDelegateTo:(id)delegate;

@end

