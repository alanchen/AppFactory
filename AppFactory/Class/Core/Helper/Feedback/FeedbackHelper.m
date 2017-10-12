//
//  FeedbackHelper.m
//  AppFactory
//
//  Created by alan on 2017/10/6.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "FeedbackHelper.h"
#import "WebControllerHelper.h"

@implementation FeedbackHelper

+(void)showFeedbackWithAdditionalContent:(NSString *)additionalContent
                                  topics:(NSArray *)topics
                                   eMail:(NSString *)email
                                    onVC:(UIViewController *)viewController
{
    CTFeedbackViewController *feedbackViewController =
    [CTFeedbackViewController controllerWithTopics:topics localizedTopics:topics];
    feedbackViewController.toRecipients = @[email];
    feedbackViewController.useHTML = NO;
    feedbackViewController.additionalDiagnosticContent = additionalContent;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [viewController presentViewController:navi animated:YES completion:nil];
}

+(void)showFacebookFanPageWithFBFanPageId:(NSString *)fbId
                         onViewController:(UIViewController *)viewController
{
    
    NSString *fbProfileURL = [NSString stringWithFormat:@"fb://profile/%@",fbId];
    NSURL *url = [NSURL URLWithString:fbProfileURL];
    
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
    }else{
        NSString *webUrl = [NSString stringWithFormat:@"https://www.facebook.com/%@",fbId];
        [WebControllerHelper showWithURLStr:webUrl on:viewController];
    }
}

@end
