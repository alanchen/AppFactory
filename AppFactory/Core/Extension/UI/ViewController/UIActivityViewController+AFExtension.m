//
//  UIActivityViewController+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIActivityViewController+AFExtension.h"

@implementation UIActivityViewController(AFExtension)

+ (UIActivityViewController *)showWithActivityItems:(NSArray *)items
                                   onViewController:(UIViewController *)viewController
                                         sourceView:(UIView *)sourceView
{
    if( ![viewController isKindOfClass:[UIViewController class]] || [items count] == 0 ){
        return nil;
    }
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items
                                                                                         applicationActivities:nil];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        activityViewController.modalPresentationStyle = UIModalPresentationPopover;
        activityViewController.popoverPresentationController.sourceView = sourceView;
    }
    
    [viewController presentViewController:activityViewController animated:YES completion:nil];

    return activityViewController;
}

@end
