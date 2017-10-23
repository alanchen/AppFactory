//
//  AFBaseViewController.m
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFBaseViewController.h"
#import "UINavigationController+AFExtension.h"
#import "UIViewController+AFExtension.h"
#import "KeyBoardMacros.h"
#import "AppFactory.h"
#import "LibsHeader.h"

@interface AFBaseViewController ()

@property (nonatomic)BOOL isFirstTimeWillAppeared;
@property (nonatomic)BOOL isFirstTimeDidAppeared;

@end

@implementation AFBaseViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(viewUpdateNotifiactionComing:)
                                                 name:UPDATE_VC_NOTI_NAME([self class])
                                               object:nil];
    
    self.isFirstTimeWillAppeared = YES;
    self.isFirstTimeDidAppeared = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor =[UIColor whiteColor];
    
    if(![self isRootViewController]){
        __weak __typeof(self) weakSelf = self;
        UIImage *back = AF_BUNDLE_IMAGE(@"navi-back");
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] bk_initWithImage:back style:UIBarButtonItemStylePlain handler:^(id sender) {
            [weakSelf popViewController];
        }];
        [self setLeftBarButtonItem:backItem];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    KEYBOARD_WILL_SHOW(self, @selector(keyboardWillShow:));
    KEYBOARD_WILL_HIDE(self, @selector(keyboardWillHide:));
    KEYBOARD_DID_SHOW(self, @selector(keyboardDidShow:));
    KEYBOARD_DID_HIDE(self, @selector(keyboardDidHide:));
    
    if(self.isFirstTimeDidAppeared){
        if([self respondsToSelector:@selector(viewDidAppearAtFirstTime)])
            [self viewDidAppearAtFirstTime];
    }else{
        if([self respondsToSelector:@selector(viewDidAppearForNotFirstTime)])
            [self viewDidAppearForNotFirstTime];
    }
    self.isFirstTimeDidAppeared = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak __typeof(self) weakSelf = self;

    if(self.isFirstTimeWillAppeared){
        if([self respondsToSelector:@selector(viewWillAppearAtFirstTime)])
            [self viewWillAppearAtFirstTime];

        [RACObserve(self, keyboardHeight) subscribeNext:^(id x) {
            if([weakSelf respondsToSelector:@selector(viewKeyboardHeightDidChanged:)])
                [weakSelf viewKeyboardHeightDidChanged:weakSelf.keyboardHeight];
        }];
    }else{
        if([self respondsToSelector:@selector(viewWillAppearForNotFirstTime)])
            [self viewWillAppearForNotFirstTime];
    }
    
    self.isFirstTimeWillAppeared = NO;
    [self.navigationController setNavigationBarHidden:self.isFullScreenViewController animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
     AFBaseViewController *lastVC = [self.navigationController.viewControllers lastObject];
    if([lastVC respondsToSelector:@selector(isFullScreenViewController)]){
        [self.navigationController setNavigationBarHidden:lastVC.isFullScreenViewController animated:YES];
    }
    
    KEYBOARD_REMOVE_OBSERVER(self);
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if( !self.navigationController ){
        if([self respondsToSelector:@selector(viewDidPoped)]){
            [self viewDidPoped];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    NOTIFICATION_REMOVE_SELF_OBSERVER;
    DLog(@"%@",self);
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    if(self.navigationController.barStyle == NavigationBarStyleLight){
        return UIStatusBarStyleDefault;
    }
    
    return UIStatusBarStyleLightContent;
}
#pragma mark - Notification

-(void)viewUpdateNotifiactionComing:(NSNotification *)noti
{
    NSString *notiName = noti.name;
    NSString *className = [notiName stringByReplacingOccurrencesOfString:updateNotiPrefix withString:@""];
    
    if([NSStringFromClass([self class]) isEqualToString:className]){
        if([self respondsToSelector:@selector(viewIsNotifiedToReloadData:)]){
            [self viewIsNotifiedToReloadData:noti.object];
        }
    }
}

#pragma mark - Action & Response

- (void)keyboardWillShow:(NSNotification*)notification
{
    if([self respondsToSelector:@selector(viewKeyboardWillShow)])
        [self viewKeyboardWillShow];
    
    @weakify(self);
    KEYBOARD_ANIMATING([notification userInfo],^(CGRect keyboardFrame) {
        @strongify(self);
        CGRect kbFrame = [self.view convertRect:keyboardFrame toView:nil];
        self.keyboardHeight = kbFrame.size.height ;
    })
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    if([self respondsToSelector:@selector(viewKeyboardWillHide)])
        [self viewKeyboardWillHide];
    
    @weakify(self);
    KEYBOARD_ANIMATING([notification userInfo],^(CGRect keyboardFrame) {
        @strongify(self);
        self.keyboardHeight = 0;
    })
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    if([self respondsToSelector:@selector(viewKeyboardDidShow)])
        [self viewKeyboardDidShow];
}

- (void)keyboardDidHide:(NSNotification*)notification
{
    if([self respondsToSelector:@selector(viewKeyboardDidHide)])
        [self viewKeyboardDidHide];
}

#pragma mark - Public Methods

-(void)pushViewController:(id)viewController
{
    [self pushViewController:viewController withAnimated:YES];
}

-(void)pushViewController:(UIViewController *)viewController withAnimated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:animated];
    
    BOOL isRootVC = [self isRootViewController];
    if(isRootVC){
        self.hidesBottomBarWhenPushed = NO;
        
        if(self.tabBarController){
            // Hack : http://www.jianshu.com/p/48e4e65aaf06
            // Try to fix iPhoneX tabbar jumps when push. Maybe one day we don't need these dirty code.
            CGRect tabFrame = self.tabBarController.tabBar.frame;
            tabFrame.origin.y = SCREEN_HEIGHT - tabFrame.size.height;
            self.tabBarController.tabBar.frame = tabFrame;
        }
    }
}

-(void)popViewController
{
    [self popViewControllerWithAnimation:YES];
}

-(void)popViewControllerWithAnimation:(BOOL)animated
{
    NOTIFICATION_REMOVE_SELF_OBSERVER;
    
    if([self.navigationController viewControllersCount]==2){ // ready to pop to root
        [self.navigationController rootViewController].hidesBottomBarWhenPushed = NO;
    }
    
    [self.navigationController popViewControllerAnimated:animated];
}

-(void)popToViewController:(UIViewController *)vc
{
    [self popToViewController:vc animated:YES];
}

-(void)popToViewController:(UIViewController *)vc animated:(BOOL)animated
{
    if(![self.navigationController isContainVC:vc] || self == vc)
        return;
    
    NSInteger vcCount = [self.navigationController viewControllersCount];
    for(NSInteger i = vcCount-1;  i>=0 ; i--){
        id eachVC = [self.navigationController viewControllers][i];
        if(eachVC == vc){
            break;
        }
        NOTIFICATION_REMOVE_OBSERVER(eachVC);
    }
    
    UIViewController *rootVC = [self.navigationController rootViewController];
    if(vc == rootVC){
        rootVC.hidesBottomBarWhenPushed = NO;
    }
    
    [self.navigationController popToViewController:vc animated:animated];
}

-(void)popToRootViewController
{
    [self popToRootViewControllerWithAnimated:YES];
}

-(void)popToRootViewControllerWithAnimated:(BOOL)animated
{
    if([self.navigationController viewControllersCount]==0)
        return;
    
    UIViewController *rootVC = [self.navigationController rootViewController];
    rootVC.hidesBottomBarWhenPushed = NO;
    for(UIViewController *vc in self.navigationController.viewControllers){
        vc.hidesBottomBarWhenPushed = NO;
        if(vc!=rootVC){
            NOTIFICATION_REMOVE_OBSERVER(vc);
        }
    }
    
    [self.navigationController popToRootViewControllerAnimated:animated];
}

#pragma mark -

-(void)setLeftBarButtonItem:(UIBarButtonItem *)item
{
    self.navigationItem.leftBarButtonItem = item;
}

-(void)setRightBarButtonItem:(UIBarButtonItem *)item
{
    self.navigationItem.rightBarButtonItem = item;
}

- (void)addCancelButtonWithBlock:(void (^)(void))block
{
    UIImage *back = AF_BUNDLE_IMAGE(@"navi-cross");
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] bk_initWithImage:back style:UIBarButtonItemStylePlain handler:^(id sender) {
        if(block) block();
    }];
    [self setLeftBarButtonItem:backItem];
}

@end
