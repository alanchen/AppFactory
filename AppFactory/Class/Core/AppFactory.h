//
//  AppFactory.h
//  AppFactory
//
//  Created by alan on 2017/10/6.
//  Copyright © 2017年 alan. All rights reserved.
//

// Base
#import "AFBaseViewController.h"
#import "AFBaseTableCell.h"
#import "AFBaseTableView.h"
#import "AFBaseTableViewController.h"
#import "AFBaseNavigationController.h"

// Helper
#import "UIComponentFactory.h"
#import "ToastMessage.h"
#import "SVProgressHUDHelper.h"

// Macros
#import "UsefulDefinition.h"
#import "LogMacros.h"
#import "DeviceMacros.h"
#import "NotificationMacros.h"
#import "NSUserDefualtsMacros.h"

// Extension
#import "UIView+AFExtension.h"
#import "UIView+AFBorder.h"
#import "UIView+AFSubView.h"
#import "UIButton+AFExtension.h"
#import "UIImage+AFExtension.h"
#import "UIImageView+AFExtension.h"
#import "UILabel+AFExtension.h"
#import "UITextField+AFExtension.h"
#import "UITextView+AFExtension.h"

#import "UIApplication+AFExtension.h"
#import "UINavigationController+AFExtension.h"
#import "UIViewController+AFExtension.h"
#import "UIAlertController+AFExtension.h"

#import "NSString+AFExtension.h"
#import "NSString+AFWebExtension.h"
#import "NSString+AFRegExtension.h"
#import "NSString+AFTimeExtension.h"
#import "NSAttributedString+AFExtension.h"
#import "NSMutableAttributedString+AFExtension.h"

#import "NSArray+AFExtension.h"
#import "NSMutableArray+AFExtension.h"
#import "NSMutableDictionary+AFExtension.h"
#import "NSObject+AFExtension.h"
#import "NSDate+AFExtension.h"
#import "NSURL+AFExtension.h"

#define AF_BUNDLE_IMAGE(name) [AppFactory imageInTheBundleWithName:name]

@interface AppFactory : NSObject

+(UIImage *)imageInTheBundleWithName:(NSString *)name;

@end

