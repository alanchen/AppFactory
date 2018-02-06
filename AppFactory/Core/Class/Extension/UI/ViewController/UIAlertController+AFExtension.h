//
//  UIAlertController+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIAlertController+Window.h"

@interface UIAlertController(AFExtension)

+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                                    leftTitle:(NSString *)leftTitle
                                   rightTitle:(NSString *)rightTitle
                                    boldRight:(BOOL)isboldRight
                                  leftHandler:(void (^)(UIAlertAction *action))leftBlock
                                 rightHandler:(void (^)(UIAlertAction *action))rightblock;

+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                                  cancelTitle:(NSString *)cancelTitle
                                   otherTitle:(NSString *)otherTitle
                                cancelHandler:(void (^)(UIAlertAction *action))cancleBlock
                                 otherHandler:(void (^)(UIAlertAction *action))otherblock;

+ (UIAlertController *)showWithTitle:(NSString *)title
                             message:(NSString *)message
                         buttonTitle:(NSString *)btnTitle
                             handler:(void (^)(UIAlertAction *action))block;


+ (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message;

+ (UIAlertController *)actionSheetControllerWithTitle:(NSString *)title message:(NSString *)message;

- (void)showActionSheetOnViewController:(UIViewController *)viewController from:(id)from;

- (UIAlertAction *)addDefaultActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))block;

- (UIAlertAction *)addActionWithTitle:(NSString *)title imageName:(NSString *)name handler:(void (^)(UIAlertAction *action))block;

- (UIAlertAction *)addActionWithTitle:(NSString *)title image:(UIImage *)image handler:(void (^)(UIAlertAction *action))block;

- (UIAlertAction *)addCancelActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))block;

- (UIAlertAction *)addDestructiveActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))block;

@end
