//
//  AFSearchBarView.h
//
//  Created by alan on 2017/9/21.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFSearchBarView;

@protocol AFSearchBarViewDelegate <NSObject>
@optional
- (void)searchViewSearchButtonClicked:(UITextField *)searchBar;
- (BOOL)searchViewShouldBeginEditing:(UITextField *)searchBar;
- (void)searchView:(AFSearchBarView *)searchView textDidChange:(NSString *)searchText;

@end

@interface AFSearchBarView : UIView

@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,weak) id<AFSearchBarViewDelegate> delegate;

+(AFSearchBarView *)view;

@end
