//
//  AFSearchBarView.m
//
//  Created by alan on 2017/9/21.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFSearchBarView.h"
#import "LibsHeader.h"
#import "DeviceMacros.h"
#import "UIView+AFExtension.h"
#import "UIView+AFBorder.h"
#import "AppFactory.h"

@interface AFSearchBarView() <UITextFieldDelegate>

@end

@implementation AFSearchBarView

+(AFSearchBarView *)view
{
    AFSearchBarView *v = [[AFSearchBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    v.backgroundColor = [UIColor clearColor];
    
    return v;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self addSubview:self.iconImageView];
        [self addSubview:self.searchTextField];
     
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@14);
            make.width.equalTo(@14);
            make.left.equalTo(@10);
            make.centerY.equalTo(self);
        }];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.searchTextField.height = 20;
    self.searchTextField.width = self.width - 30;
    self.searchTextField.left = 29;
    self.searchTextField.centerY = self.height/2;
}

-(CGSize)intrinsicContentSize
{
    return CGSizeMake(SCREEN_WIDTH, 30);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([self.delegate respondsToSelector:@selector(searchViewShouldBeginEditing:)]){
      return [self.delegate searchViewShouldBeginEditing:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([self.delegate respondsToSelector:@selector(searchViewSearchButtonClicked:)]){
        [self.delegate searchViewSearchButtonClicked:textField];
    }
    return YES;
}

#pragma mark - Setter & Getter

-(UIView *)bgView
{
    if(!_bgView){
        _bgView = ({
            UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
            [v setCornerRadius:4 borderColor:[UIColor colorWithHex:0xdddddd] borderWidth:1];
            v.backgroundColor = [UIColor colorWithHex:0xeeeeee];
            v.clipsToBounds = YES;
            v;
        });
    }
    
    return _bgView;
}

-(UIImageView *)iconImageView
{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc] initWithImage:AF_BUNDLE_IMAGE(@"search-magnifier")];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_iconImageView setSize:CGSizeMake(14, 14)];
    }
    
    return _iconImageView;
}

-(UITextField *)searchTextField
{
    if(!_searchTextField){
       _searchTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        [_searchTextField setBorderStyle:UITextBorderStyleNone];
        _searchTextField.clipsToBounds = YES;
        _searchTextField.font = [UIFont systemFontOfSize:14];
        _searchTextField.textAlignment = NSTextAlignmentLeft;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.delegate = self;
        _searchTextField.enablesReturnKeyAutomatically = YES;
        _searchTextField.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        @weakify(self);
        [_searchTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            if([self.delegate respondsToSelector:@selector(searchView:textDidChange:)]){
                [self.delegate searchView:self textDidChange:x];
            }
        }];
    }
    
    return _searchTextField;
}

@end
