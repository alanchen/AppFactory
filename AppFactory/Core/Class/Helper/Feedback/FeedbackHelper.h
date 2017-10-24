//
//  FeedbackHelper.h
//  AppFactory
//
//  Created by alan on 2017/10/6.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFeedbackViewController.h"

@interface FeedbackHelper : NSObject

+(CTFeedbackViewController *)showFeedbackWithAdditionalContent:(NSString *)additionalContent
                                                        topics:(NSArray *)topics
                                                         eMail:(NSString *)email
                                                          onVC:(UIViewController *)viewController
                                                     doneBlock:(void (^)(CTFeedbackViewController *vc))block;

+(void)showFacebookFanPageWithFBFanPageId:(NSString *)fbId
                         onViewController:(UIViewController *)viewController;

@end
