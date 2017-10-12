//
//  NSString+AFWebExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface  NSString(AFWebExtension)

- (NSString *) af_sha1;

- (NSString *) urlEncode ;

- (NSString *) unescapeFromHTML;

@end
