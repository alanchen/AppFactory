//
//  UIAlertController+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIAlertController+AFExtension.h"

@implementation UIAlertController(AFExtension)

+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                                  cancelTitle:(NSString *)cancelTitle
                                   otherTitle:(NSString *)otherTitle
                                cancelHandler:(void (^)(UIAlertAction *action))cancleBlock
                                 otherHandler:(void (^)(UIAlertAction *action))otherblock
{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message];
    if(cancelTitle){
        [alertVC addCancelActionWithTitle:cancelTitle handler:cancleBlock];
    }
    if(otherTitle){
        [alertVC addDefaultActionWithTitle:otherTitle handler:otherblock];
    }
    [alertVC show];
    return alertVC;
}

+ (UIAlertController *)showWithTitle:(NSString *)title
                             message:(NSString *)message
                         buttonTitle:(NSString *)btnTitle
                             handler:(void (^)(UIAlertAction *action))block
{
    return [self showAlertViewWithTitle:title
                                message:message
                            cancelTitle:btnTitle
                             otherTitle:nil
                          cancelHandler:block
                           otherHandler:nil];
}

+ (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    return vc;
}

+ (UIAlertController *)actionSheetControllerWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    return vc;
}

- (void)showActionSheetOnViewController:(UIViewController *)viewController from:(id)from
{
    UIAlertController *alertController = self;
    
    if([from isKindOfClass:[UIBarButtonItem class]]){
        alertController.popoverPresentationController.barButtonItem = from;
    }else if([from isKindOfClass:[UIView class]]){
        UIView *view = from;
        alertController.popoverPresentationController.sourceView = view;
        alertController.popoverPresentationController.sourceRect = view.bounds;
    }else{
        alertController.popoverPresentationController.sourceView = viewController.view;
        alertController.popoverPresentationController.sourceRect = viewController.view.bounds;
    }
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)addDefaultActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))block
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:block];
    [self addAction:action];
}

- (void)addActionWithTitle:(NSString *)title imageName:(NSString *)name handler:(void (^)(UIAlertAction *action))block
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:block];
    UIImage *img = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [action setValue:img forKey:@"image"];
    [self addAction:action];
}

- (void)addActionWithTitle:(NSString *)title image:(UIImage *)image handler:(void (^)(UIAlertAction *action))block
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:block];
    if(image){[action setValue:image forKey:@"image"]; }
    [self addAction:action];
}

- (void)addCancelActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))block
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:block];
    [self addAction:action];
}

- (void)addDestructiveActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))block
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:block];
    [self addAction:action];
}

@end
