//
//  UIImageView+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>

@interface UIImageView(AFExtension)

- (void)af_sizeToFitTheSize:(CGSize)size;

+ (UIImage *)cachedImageWithUrl:(NSString *)url;

#pragma mark - URL

- (void)setImageWithURLString:(NSString *)urlStr;

- (void)setImageWithURLString:(NSString *)urlStr
                  placeholder:(UIImage *)placeholderImage;

- (void)setImageWithURL:(NSString *)url
            placeholder:(UIImage *)placeholder
                success:(void (^)(UIImage *image))success
                failure:(void (^)(NSError *error))failure;

- (void)af_loadImageUrlWithSpinner:(NSString *)urlStr
                        completion:(void (^)(UIImage *image))completion;

- (void)af_loadImageUrlWithSpinner:(NSString *)urlStr;

- (void)af_loadImageWithURL:(NSString *)urlStr
             placeholderImg:(UIImage *)img
            placeholderSize:(CGSize)size
                 completion:(void (^)(UIImage *image))completion;

@end
