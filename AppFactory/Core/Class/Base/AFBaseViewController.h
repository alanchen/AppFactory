//
//  AFBaseViewController.h
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *updateNotiPrefix = @"AF_UPDATE_BASE_VC_";
#define UPDATE_VC_NOTI_NAME(class) [NSString stringWithFormat:@"%@%@",updateNotiPrefix,NSStringFromClass(class)]
#define VC_UPDATE_POSTNOTI(vcClass,data) [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_VC_NOTI_NAME(vcClass) object:data]

@protocol AFBaseViewControllerDelegate <NSObject>

@optional
-(void)viewDidAppearAtFirstTime;
-(void)viewDidAppearForNotFirstTime;
-(void)viewWillAppearAtFirstTime;
-(void)viewWillAppearForNotFirstTime;

-(void)viewDidPoped;
-(void)viewKeyboardHeightDidChanged:(float)keyboardHeight;
-(void)viewIsNotifiedToReloadData:(id)data; // use VC_UPDATE_POSTNOTI(vcClass,data) to trigger

-(void)viewKeyboardDidShow;
-(void)viewKeyboardDidHide;
-(void)viewKeyboardWillShow;
-(void)viewKeyboardWillHide;

@end

@interface AFBaseViewController : UIViewController <AFBaseViewControllerDelegate>

@property (nonatomic) float keyboardHeight;
@property (nonatomic) BOOL isFullScreenViewController;

-(void)pushViewController:(id)viewController;
-(void)pushViewController:(id)viewController withAnimated:(BOOL)animated;

-(void)popViewController;
-(void)popViewControllerWithAnimation:(BOOL)animated;
-(void)popToViewController:(UIViewController *)vc;
-(void)popToViewController:(UIViewController *)vc animated:(BOOL)animated;
-(void)popToRootViewController;
-(void)popToRootViewControllerWithAnimated:(BOOL)animated;

-(void)setLeftBarButtonItem:(UIBarButtonItem *)item;
-(void)setRightBarButtonItem:(UIBarButtonItem *)item;
-(void)addCancelButtonWithBlock:(void (^)(void))block;

@end

