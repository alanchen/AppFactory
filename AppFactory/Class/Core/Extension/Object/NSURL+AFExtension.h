//
//  NSURL+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSURL(AFExtension)

// It's for opening SFSafariViewController correcly
+ (NSURL *)urlByValidationWithString:(NSString *)string;

- (NSURL *)urlByAddingValidHTTPSchemeIfNeed;

@end
