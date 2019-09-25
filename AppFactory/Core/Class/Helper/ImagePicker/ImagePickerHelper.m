//
//  ImagePickerHelper.m
//  FreePoint
//
//  Created by alan on 2015/2/16.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "ImagePickerHelper.h"
#import "UIImage+Resizing.h"
#import "UIAlertController+AFExtension.h"
#import "UsefulDefinition.h"
#import "DeviceMacros.h"
#import "LibsHeader.h"
#import <Photos/Photos.h>

@interface ImagePickerHelper()<UINavigationControllerDelegate>

@end

@implementation ImagePickerHelper

+(ImagePickerHelper *)sharedInstance
{
    static ImagePickerHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ImagePickerHelper alloc] init];
    });
    
    return sharedInstance;
}

-(void)showImagePickerOnViewController:(UIViewController *)vc
                              onButton:(id)btn
                               success:(void (^)(UIImage *image))successBlock
                                cancel:(void (^)())cancelBlock
{
    [self showImagePickerOnViewController:vc
                                 onButton:btn
                              cancelTitle:nil
                              cameraTitle:nil
                               albumTitle:nil
                                  success:successBlock
                                   cancel:cancelBlock];
}

-(void)showImagePickerOnViewController:(UIViewController *)vc
                              onButton:(id)btn
                           cancelTitle:(NSString *)cancelTitle
                           cameraTitle:(NSString *)cameraTitle
                            albumTitle:(NSString *)albumTitle
                               success:(void (^)(UIImage *image))successBlock
                                cancel:(void (^)())cancelBlock
{
    vc = NULL_TEST(vc, WIN_ROOT_VC);

    void(^imageDidCancelBlock)() = ^(UIImagePickerController *ipc){
        [ipc dismissViewControllerAnimated:YES completion:nil];
        if(cancelBlock)
            cancelBlock();
    };

    void(^imageDidComplete)() = ^(UIImagePickerController *ipc, UIImage *image){
        [ipc dismissViewControllerAnimated:YES completion:nil];
        if(image && successBlock)
            successBlock(image);
    };
    
    UIAlertController *actionSheet = [UIAlertController actionSheetControllerWithTitle:nil message:nil];
    [actionSheet addCancelActionWithTitle:cancelTitle?cancelTitle:@"取消" handler:^(UIAlertAction *action) { if(cancelBlock) cancelBlock();}];
    [actionSheet addDefaultActionWithTitle:cameraTitle?cameraTitle:@"拍照" handler:^(UIAlertAction *action) {
        [self presentCameraPickerOn:vc completion:imageDidComplete cancel:imageDidCancelBlock];
    }];
    
    [actionSheet addDefaultActionWithTitle:albumTitle?albumTitle:@"挑選照片" handler:^(UIAlertAction *action) {
        [self presentAlbumPickerOn:vc completion:imageDidComplete cancel:imageDidCancelBlock];
    }];
    
    [actionSheet showActionSheetOnViewController:vc from:btn];
}

#pragma  mark -

-(UIImagePickerController *)presentCameraPickerOn:(id)vc
                                         compress:(BOOL)compress
                                       completion:(void (^)(UIImagePickerController * ,UIImage *))completion
                                           cancel:(void (^)(UIImagePickerController *)) cancel
{
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if(cancel)
            cancel(nil);
        return nil;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    imagePickerController.allowsEditing = NO;
    
    [imagePickerController setBk_didCancelBlock:^(UIImagePickerController *ipc) {
        if(cancel)
            cancel(ipc);
    }];
    
    [imagePickerController setBk_didFinishPickingMediaBlock:^(UIImagePickerController *ipc, NSDictionary *info) {
        if(compress){
            UIImage *img = [self compressImageFromPickerInfo:info];
            if(completion) completion(ipc,img);
        }else{
            UIImage *img = [self imageFromPickerInfo:info];
            if(completion) completion(ipc,img);
        }
    }];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [vc presentViewController:imagePickerController animated:YES completion:nil];
    }];
    
    return imagePickerController;
}

-(UIImagePickerController *)presentAlbumPickerOn:(id)vc
                                        compress:(BOOL)compress
                                      completion:(void (^)(UIImagePickerController * ,UIImage *)) completion
                                          cancel:(void (^)(UIImagePickerController *)) cancel
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        if(cancel)
            cancel(nil);
        return nil;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = NO;
    
    [imagePickerController setBk_didCancelBlock:^(UIImagePickerController *ipc) {
        if(cancel)
            cancel(ipc);
    }];
    
    [imagePickerController setBk_didFinishPickingMediaBlock:^(UIImagePickerController *ipc, NSDictionary *info) {
        if(compress){
            UIImage *img = [self compressImageFromPickerInfo:info];
            if(completion) completion(ipc,img);
        }else{
            UIImage *img = [self imageFromPickerInfo:info];
            if(completion) completion(ipc,img);
        }
    }];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [vc presentViewController:imagePickerController animated:YES completion:nil];
    }];
    
    return imagePickerController;
}

-(UIImagePickerController *)presentCameraPickerOn:(id)vc
                                       completion:(void (^)(UIImagePickerController * ,UIImage *))completion
                                           cancel:(void (^)(UIImagePickerController *)) cancel
{
    return [self presentCameraPickerOn:vc compress:YES completion:completion cancel:cancel];
}

-(UIImagePickerController *)presentAlbumPickerOn:(id)vc
                                      completion:(void (^)(UIImagePickerController * ,UIImage *)) completion
                                          cancel:(void (^)(UIImagePickerController *)) cancel
{
    return [self presentAlbumPickerOn:vc compress:YES completion:completion cancel:cancel];
}

+(void)checkAuthorizationWithMessage:(NSString *)msg
                          cacnelText:(NSString *)cancelText
                            openText:(NSString *)openText
                           doneBlock:(void (^)(BOOL))block
{
    void (^showAlert)() = ^void() {
        [UIAlertController showAlertViewWithTitle:nil
                                          message:msg
                                      cancelTitle:cancelText
                                       otherTitle:openText
                                    cancelHandler:^(UIAlertAction *action) {
                                        if(block){block(NO);}
                                    } otherHandler:^(UIAlertAction *action) {
                                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                        [[UIApplication sharedApplication] openURL:url];
                                        if(block){block(NO);}
                                    }];
    };
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized){
        if(block) {block(YES);}
    }else if (status == PHAuthorizationStatusDenied){
        showAlert();
    }else if (status == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized){
                [NSObject bk_performBlock:^(){if(block){block(YES);}}onQueue:dispatch_get_main_queue() afterDelay:0.3];
            } else{
                [NSObject bk_performBlock:^(){showAlert();}onQueue:dispatch_get_main_queue() afterDelay:0.3];
            }
        }];
    }
}

#pragma  mark - Private Method

-(UIImage *) imageFromPickerInfo:(id)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    return image;
}

-(UIImage *) compressImageFromPickerInfo:(id)info
{
    UIImage *image = [self imageFromPickerInfo:info];
    CGSize maxSize = CGSizeMake(800,800);
    if(image.size.width>maxSize.width || image.size.height>maxSize.height)
        image = [image scaleToSize:maxSize usingMode:NYXResizeModeAspectFit];
    
    return image;
}

@end
