//
//  PMCountryPickerViewController.h
//  PigMarket
//
//  Created by alan on 2015/7/8.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryCodePicker.h"
#import "AFBaseViewController.h"
#import "AFSearchBarView.h"

@class AFCountryPickerViewController;
@protocol AFCountryPickerDelegate <NSObject>
@optional
-(void)countryPickerDelegateDidSelected:(CountryModel *)model picker:(AFCountryPickerViewController *)picker;
@end

@interface AFCountryPickerViewController : AFBaseViewController
@property (nonatomic,strong) CountryModel *selectedCountryModel;
@property (nonatomic,weak) id<AFCountryPickerDelegate> delegate;
@property (nonatomic,strong) AFSearchBarView *searchView;

-(void)setSelectTintColor:(UIColor *)color;
-(void)setCellTextColor:(UIColor *)color;
@end

