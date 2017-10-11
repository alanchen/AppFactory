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
    [actionSheet addCancelActionWithTitle:@"取消" handler:^(UIAlertAction *action) { if(cancelBlock) cancelBlock();}];
    [actionSheet addDefaultActionWithTitle:@"相機" handler:^(UIAlertAction *action) {
        [self presentCameraPickerOn:vc completion:imageDidComplete cancel:imageDidCancelBlock];
    }];
    
    [actionSheet addDefaultActionWithTitle:@"相簿" handler:^(UIAlertAction *action) {
        [self presentAlbumPickerOn:vc completion:imageDidComplete cancel:imageDidCancelBlock];
    }];
    
    [actionSheet showActionSheetOnViewController:vc from:btn];
}

#pragma  mark -

-(UIImagePickerController *)presentCameraPickerOn:(id)vc
                                       completion:(void (^)(UIImagePickerController * ,UIImage *))completion
                                           cancel:(void (^)(UIImagePickerController *)) cancel
{
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if(cancel)
            cancel(nil);
        return nil;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    imagePickerController.allowsEditing = NO;
    
    [imagePickerController setBk_didCancelBlock:^(UIImagePickerController *ipc) {
        if(cancel)
            cancel(ipc);
    }];
    
    [imagePickerController setBk_didFinishPickingMediaBlock:^(UIImagePickerController *ipc, NSDictionary *info) {
        UIImage *img = [self compressImageFromPickerInfo:info];
        if(completion)
            completion(ipc,img);
    }];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [vc presentViewController:imagePickerController animated:YES completion:nil];
    }];
    
    return imagePickerController;
}

-(UIImagePickerController *)presentAlbumPickerOn:(id)vc
                                      completion:(void (^)(UIImagePickerController * ,UIImage *)) completion
                                          cancel:(void (^)(UIImagePickerController *)) cancel
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        if(cancel)
            cancel(nil);
        return nil;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = NO;
    
    [imagePickerController setBk_didCancelBlock:^(UIImagePickerController *ipc) {
        if(cancel)
            cancel(ipc);
    }];
    
    [imagePickerController setBk_didFinishPickingMediaBlock:^(UIImagePickerController *ipc, NSDictionary *info) {
        UIImage *img = [self compressImageFromPickerInfo:info];
        if(completion)
            completion(ipc,img);
    }];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [vc presentViewController:imagePickerController animated:YES completion:nil];
    }];
    
    return imagePickerController;
}

#pragma  mark - Private Method

-(UIImage *) compressImageFromPickerInfo:(id)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGSize maxSize = CGSizeMake(800,800);
    if(image.size.width>maxSize.width || image.size.height>maxSize.height)
        image = [image scaleToSize:maxSize usingMode:NYXResizeModeAspectFit];
    
    return image;
}

@end
