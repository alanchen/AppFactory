//
//  FeedbackHelper.m
//  AppFactory
//
//  Created by alan on 2017/10/6.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "FeedbackHelper.h"
#import "WebControllerHelper.h"

@interface FeedbackHelper() <CTFeedbackViewControllerDelegate>
@property (nonatomic,copy) void (^finishedBlock)(CTFeedbackViewController* vc);
@end

@implementation FeedbackHelper

+(FeedbackHelper *)sharedInstance
{
    static FeedbackHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FeedbackHelper alloc] init];
    });
    
    return sharedInstance;
}

- (void)feedbackViewController:(CTFeedbackViewController *)controller didFinishWithMailComposeResult:(MFMailComposeResult)result error:(NSError *)error;
{
    if([FeedbackHelper sharedInstance].finishedBlock){
        [FeedbackHelper sharedInstance].finishedBlock(controller);
        [FeedbackHelper sharedInstance].finishedBlock = nil;
    }
}

+(CTFeedbackViewController *)showFeedbackWithAdditionalContent:(NSString *)additionalContent
                                  topics:(NSArray *)topics
                                   eMail:(NSString *)email
                                    onVC:(UIViewController *)viewController
                               doneBlock:(void (^)(CTFeedbackViewController *vc))block;

{
    CTFeedbackViewController *feedbackViewController =
    [CTFeedbackViewController controllerWithTopics:topics localizedTopics:topics];
    feedbackViewController.toRecipients = @[email];
    feedbackViewController.useHTML = NO;
    feedbackViewController.additionalDiagnosticContent = additionalContent;
    feedbackViewController.delegate = [FeedbackHelper sharedInstance];
    [FeedbackHelper sharedInstance].finishedBlock = block;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    [viewController presentViewController:navi animated:YES completion:nil];
    
    return feedbackViewController;
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
