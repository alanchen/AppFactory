//
//  ACPhotoViewer.h
//  AppFactory
//
//  Created by alan on 2021/5/25.
//  Copyright © 2021 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

// Source code:
// https://github.com/huang-kun/AFTPhotoScroller

@class ACPhotoViewer;

@protocol ACPhotoViewerDelegate <NSObject>
@optional

- (void)photoViewer:(ACPhotoViewer *)photoViewer scrollToPageAtIndex:(NSUInteger)index; // Only drag-to-scroll will trigger this method.
- (void)photoViewer:(ACPhotoViewer *)photoViewer didShowPhotoAtIndex:(NSUInteger)index;
- (BOOL)photoViewer:(ACPhotoViewer *)photoViewer showCoverViewAtIndex:(NSUInteger)index;

- (UIView *)pageCoverView;
- (UIView *)pagePlaceholderView;

@end

@interface ACPhotoViewer : UIView

@property (nonatomic, weak) id <ACPhotoViewerDelegate> delegate;

- (id)initWithURLs:(NSArray *)urls;

- (NSInteger)currentIndex;
- (NSInteger)numberOfPages;

- (void)reloadData;
- (void)reloadWithUrls:(NSArray *)urls;
- (void)showPageAtIndex:(NSInteger)index; // This will only trigger didShowPhotoAtIndex

@end

