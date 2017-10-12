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

-(UIImagePickerController *)presentCameraPickerOn:(id)vc
                                       completion:(void (^)(UIImagePickerController * ,UIImage *))completion
                                           cancel:(void (^)(UIImagePickerController *)) cancel;

-(UIImagePickerController *)presentAlbumPickerOn:(id)vc
                                      completion:(void (^)(UIImagePickerController * ,UIImage *)) completion
                                          cancel:(void (^)(UIImagePickerController *)) cancel;

@end
