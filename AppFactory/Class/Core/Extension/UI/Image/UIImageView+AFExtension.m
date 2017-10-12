//
//  UIImageView+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIImageView+AFExtension.h"
#import "UIView+AFSubView.h"
#import "LibsHeader.h"

@implementation UIImageView(AFExtension)

- (void)af_sizeToFitTheSize:(CGSize)size
{
    UIImage *image = self.image;
    float imgH = image.size.height;
    float imgW = image.size.width;
    
    if(image == nil || imgW == 0 || imgH == 0)
        return ;
    
    BOOL isLandScapeImage = imgW > imgH;
    CGFloat resultW, resultH;
    
    if(isLandScapeImage)
    {
        float ratio = imgW / imgH;
        float h = size.width / ratio ;
        float w = size.width;
        
        if(h > size.height){
            h = size.height;
            w = ratio*h;
        }
        
        resultW = w;
        resultH = h;
    } else {
        float ratio = imgH / imgW;
        float w = size.height / ratio;
        float h = size.height;
        
        if(w > size.width){
            w = size.width;
            h = w*ratio;
        }
        
        resultW = w;
        resultH = h;
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, resultW, resultH);
}

+ (UIImage *)cachedImageWithUrl:(NSString *)url
{
    UIImage *imageCached = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
    return imageCached;
}

#pragma mark - URL

- (void)setImageWithURLString:(NSString *)urlStr
{
    [self setImageWithURLString:urlStr placeholder:nil];
}

- (void)setImageWithURLString:(NSString *)urlStr
                  placeholder:(UIImage *)placeholderImage
{
    [self setImageWithURL:urlStr placeholder:placeholderImage success:nil failure:nil];
}

- (void)setImageWithURL:(NSString *)url
            placeholder:(UIImage *)placeholder
                success:(void (^)(UIImage *image))success
                failure:(void (^)(NSError *error))failure
{
    if(![url isKindOfClass:[NSString class]]){
        url = @"";
    }
    
    if(![placeholder isKindOfClass:[UIImage class]]){
        placeholder = nil;
    }
    
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:placeholder
                     options:SDWebImageRetryFailed
                    progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                        
                    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                        if(error){
                            if(failure) failure(error);
                        }else{
                            if(success) success(image);
                        }
                    }];
}

/*******************************
 
 *******************************/

- (void)af_loadImageUrlWithSpinner:(NSString *)urlStr
                        completion:(void (^)(UIImage *image))completion
{
    UIImage *imageCached = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if(imageCached){
        [self.af_spinner stopAnimating];
        self.image = imageCached;
        if(completion) completion(imageCached);
        return;
    }
    
    [self.af_spinner startAnimating];
    self.image = nil;
    __weak __typeof(self)weakSelf = self;
    [self setImageWithURL:urlStr
              placeholder:nil
                  success:^(UIImage *image) {
                      [weakSelf.af_spinner stopAnimating];
                      dispatch_async(dispatch_get_main_queue(), ^{
                          if(completion) completion(weakSelf.image);
                      });
                  } failure:^(NSError *error) {
                      if(error.code != -999){ //cancel
                          return ;
                      }
                      [weakSelf.af_spinner stopAnimating];
                      dispatch_async(dispatch_get_main_queue(), ^{
                          if(completion) completion(nil);
                      });
                  }];
}


- (void)af_loadImageUrlWithSpinner:(NSString *)urlStr
{
    [self af_loadImageUrlWithSpinner:urlStr completion:nil];
}

- (void)af_loadImageWithURL:(NSString *)urlStr
             placeholderImg:(UIImage *)img
            placeholderSize:(CGSize)size
                 completion:(void (^)(UIImage *image))completion
{
    self.af_placeholderImageView.image = img;
    self.af_placeholderImageView.size = size;
    self.af_placeholderImageView.hidden = NO;
    
    __weak __typeof(self)weakSelf = self;
    [self setImageWithURL:urlStr placeholder:nil success:^(UIImage *image) {
        weakSelf.af_placeholderImageView.hidden = YES;
        if(completion) completion(image);
    } failure:^(NSError *error) {
        weakSelf.af_placeholderImageView.hidden = NO;
        if(completion) completion(nil);
    }];
}



@end
