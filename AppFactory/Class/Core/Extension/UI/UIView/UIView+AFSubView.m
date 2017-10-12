//
//  UIView+AFSubView.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIView+AFSubView.h"
#import "LibsHeader.h"

@interface UIView(private)
@property (nonatomic,strong) UIActivityIndicatorView *mySpinner;
@property (nonatomic,strong) UIImageView *myPlaceholderImageView;
@end
@implementation UIView(private)
SYNTHESIZE_ASC_OBJ(mySpinner, setMySpinner);
SYNTHESIZE_ASC_OBJ(myPlaceholderImageView, setMyPlaceholderImageView);
@end

@implementation UIView(AFSubView)

#pragma mark - Getter

- (UIActivityIndicatorView *)af_spinner{
    if(!self.mySpinner){
        self.mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.mySpinner setHidesWhenStopped:YES];
        [self addSubview:self.mySpinner];
        [self.mySpinner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    
    return  self.mySpinner;
}

- (UIImageView *)af_placeholderImageView{
    if(!self.myPlaceholderImageView){
        self.myPlaceholderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [self.myPlaceholderImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.myPlaceholderImageView];
        [self.myPlaceholderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    
    return  self.myPlaceholderImageView;
}

@end
