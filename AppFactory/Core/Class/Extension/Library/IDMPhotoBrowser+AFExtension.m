//
//  IDMPhotoBrowser+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "IDMPhotoBrowser+AFExtension.h"

@implementation IDMPhotoBrowser(AFExtension)

+(IDMPhotoBrowser *)createBrowserWithPhotos:(NSArray *)photos
                                   fromView:(UIView *)view
                                 scaleImage:(UIImage *)scaleImage
                                      index:(NSUInteger)index
{
    IDMPhotoBrowser *browser;
    
    if(view){
        browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos animatedFromView:view];
    }else{
        browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
    }
    
    browser.displayActionButton = NO;
    browser.displayArrowButton = NO;
    browser.displayCounterLabel = YES;
    browser.displayDoneButton = NO;
    browser.usePopAnimation = YES;
    browser.useWhiteBackgroundColor = NO;
    browser.scaleImage = scaleImage;
    [browser setInitialPageIndex:index];
    
    return browser;
}

+(IDMPhotoBrowser *)createBrowserWithUrls:(NSArray *)urls
                                 fromView:(UIView *)view
                               scaleImage:(UIImage *)scaleImage
                                    index:(NSUInteger)index
{
    if(![urls count])
        return nil;
    
    NSArray *photos = [self createPhotoModelsWithUrls:urls];
    IDMPhotoBrowser *browser = [self createBrowserWithPhotos:photos fromView:view scaleImage:scaleImage index:index];
    
    return browser;
}

+(IDMPhotoBrowser *)createBrowserWithUrls:(NSArray *)urls
                            fromImageView:(UIImageView *)imageView
                                    index:(NSUInteger)index
{
    UIImage *img;
    if([imageView isKindOfClass:[UIImageView class]]){
        img = imageView.image;
    }
    
    return [self createBrowserWithUrls:urls fromView:imageView scaleImage:img index:index];
}

+(IDMPhoto *)createPhotoModelWithUrl:(NSString *)url
{
    return [IDMPhoto photoWithURL:[NSURL URLWithString:url]];
}

+(NSArray *)createPhotoModelsWithUrls:(NSArray *)urls
{
    NSMutableArray *result = [NSMutableArray array];
    
    [urls enumerateObjectsUsingBlock:^(NSString *url, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:[self createPhotoModelWithUrl:url]];
    }];
    
    return result;
}

@end

