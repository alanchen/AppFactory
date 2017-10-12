//
//  IDMPhotoBrowser+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IDMPhotoBrowser/IDMPhotoBrowser.h>

@interface IDMPhotoBrowser(AFExtension)

+(IDMPhotoBrowser *)createBrowserWithPhotos:(NSArray *)photos
                                   fromView:(UIView *)view
                                 scaleImage:(UIImage *)scaleImage
                                      index:(NSUInteger)index;

+(IDMPhotoBrowser *)createBrowserWithUrls:(NSArray *)urls
                                 fromView:(UIView *)view
                               scaleImage:(UIImage *)scaleImage
                                    index:(NSUInteger)index;

+(IDMPhotoBrowser *)createBrowserWithUrls:(NSArray *)urls
                            fromImageView:(UIImageView *)imageView
                                    index:(NSUInteger)index;

+(IDMPhoto *)createPhotoModelWithUrl:(NSString *)url;

+(NSArray *)createPhotoModelsWithUrls:(NSArray *)urls;



@end
