//
//  ImagePickerHelper.h
//  FreePoint
//
//  Created by alan on 2015/2/16.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImagePickerHelper : NSObject

+(ImagePickerHelper *)sharedInstance;

-(void)showImagePickerOnViewController:(UIViewController *)vc
                              onButton:(id)btn
                               success:(void (^)(UIImage *image))success
                                cancel:(void (^)())cancel;

-(void)showImagePickerOnViewController:(UIViewController *)vc
                              onButton:(id)btn
                           cancelTitle:(NSString *)cancelTitle
                           cameraTitle:(NSString *)cameraTitle
                            albumTitle:(NSString *)albumTitle
                               success:(void (^)(UIImage *image))successBlock
                                cancel:(void (^)())cancelBlock;

-(UIImagePickerController *)presentCameraPickerOn:(id)vc
                                       completion:(void (^)(UIImagePickerController * ,UIImage *))completion
                                           cancel:(void (^)(UIImagePickerController *)) cancel;

-(UIImagePickerController *)presentAlbumPickerOn:(id)vc
                                      completion:(void (^)(UIImagePickerController * ,UIImage *)) completion
                                          cancel:(void (^)(UIImagePickerController *)) cancel;


+(void)checkAuthorizationWithMessage:(NSString *)msg
                          cacnelText:(NSString *)cancelText
                            openText:(NSString *)openText
                           doneBlock:(void (^)(BOOL success))block;

@end
