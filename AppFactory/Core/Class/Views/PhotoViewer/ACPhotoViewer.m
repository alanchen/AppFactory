//
//  ACPhotoViewer.m
//  AppFactory
//
//  Created by alan on 2021/5/25.
//  Copyright © 2021 alan. All rights reserved.
//

#import "ACPhotoViewer.h"
#import "AFTPagingScrollView.h"
#import "AFTImageScrollView.h"

#import "AppFactory.h"
#import "LibsHeader.h"

typedef enum : NSUInteger {
    ACPhotoViewerDefault,
    ACPhotoViewerLoading,
    ACPhotoViewerFailed,
    ACPhotoViewerSuccess,
} ACPhotoViewerLoadingStatus;

@interface ACPhotoViewer()<AFTPagingScrollViewDataSource, AFTPagingScrollViewDelegate>
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) AFTPagingScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, strong) NSMutableDictionary *failedUrls;
@property (nonatomic, strong) NSMutableDictionary *loadingUrls;

@end

@implementation ACPhotoViewer

#pragma mark - Life Cycle

- (id)initWithURLs:(NSArray *)urls;
{
    ACPhotoViewer *v = [[[self class] alloc] initWithFrame:CGRectMake(0, 0, 320, 480) urls:urls];
    return v;
}

- (instancetype)initWithFrame:(CGRect)frame urls:(NSArray *)urls
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        self.urls = urls;
        self.failedUrls = [@{} mutableCopy];
        self.loadingUrls = [@{} mutableCopy];

        [self addSubview:self.mainScrollView];
        [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        self.mainScrollView.delegate = self;
        self.mainScrollView.dataSource = self;
        self.mainScrollView.paddingBetweenPages = 6;
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - AFTPagingScrollViewDataSource

- (NSInteger)numberOfPagesInPagingScrollView:(AFTPagingScrollView *)pagingScrollView {
    return [self.urls count];
}

- (UIImage *)pagingScrollView:(AFTPagingScrollView *)pagingScrollView imageForPageAtIndex:(NSInteger)pageIndex {

    NSString *url = [self.urls safelyObjectAtIndex:pageIndex];
    if(!url){
        [self configLoadingStatusAtIndex:pageIndex status:ACPhotoViewerSuccess];
        return self.placeholderImage;
    }
    
    UIImage *imageCached = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
    if(imageCached){
        [self configLoadingStatusAtIndex:pageIndex status:ACPhotoViewerSuccess];
        return imageCached;
    }
    
    if([self checkIfInvalidUrl:url]){
        [self configLoadingStatusAtIndex:pageIndex status:ACPhotoViewerFailed];
        return self.placeholderImage;
    }
    
    [self configLoadingStatusAtIndex:pageIndex status:ACPhotoViewerLoading];
    if([self.loadingUrls safelyObjectForKey:url]){
        return self.placeholderImage;
    }
    __weak __typeof(self) weakSelf = self;
    [self.loadingUrls safelySetObject:@(YES) forKey:url];
    [self downloadImageAtPageIndex:pageIndex completion:^(BOOL success) {
        [weakSelf.loadingUrls removeObjectForKey:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainScrollView reloadPageAtIndex:pageIndex];
        });
    }];

    return self.placeholderImage;
}

#pragma mark - AFTPagingScrollViewDelegate

- (void)pagingScrollView:(AFTPagingScrollView *)pagingScrollView didCreateImageScrollView:(UIScrollView *)imageScrollView
{
    if([self.delegate respondsToSelector:@selector(pagePlaceholderView)]){
        UIView *placeholderView = [self.delegate pagePlaceholderView];
        placeholderView.hidden = YES;
        [imageScrollView addSubview:placeholderView];
        ((AFTImageScrollView *)imageScrollView).placeholderView = placeholderView;
        [placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageScrollView);
            make.centerY.equalTo(imageScrollView);
            make.height.equalTo(@(placeholderView.height));
            make.width.equalTo(@(placeholderView.width));
        }];
    }
    
    if([self.delegate respondsToSelector:@selector(pageCoverView)]){
        UIView *coverView = [self.delegate pageCoverView];
        [imageScrollView addSubview:coverView];
        ((AFTImageScrollView *)imageScrollView).customCoverView = coverView;
        [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@0);
            make.height.equalTo(imageScrollView.mas_height);
            make.width.equalTo(imageScrollView.mas_width);
        }];
    }
    
}

- (void)pagingScrollView:(AFTPagingScrollView *)pagingScrollView
         imageScrollView:(UIScrollView *)imageScrollView
    didReuseForPageIndex:(NSInteger)pageIndex
{
//    NSLog(@"didDisplayPageAtIndex %zd",pageIndex);
    
    [self configCustomCoverViewAtIndex:pageIndex-1];
    [self configCustomCoverViewAtIndex:pageIndex];
    [self configCustomCoverViewAtIndex:pageIndex+1];

    [self.mainScrollView reloadPageAtIndex:pageIndex];
}

- (void)pagingScrollView:(AFTPagingScrollView *)pagingScrollView didDisplayPageAtIndex:(NSInteger)pageIndex
{
    [self configCustomCoverViewAtIndex:pageIndex-1];
    [self configCustomCoverViewAtIndex:pageIndex];
    [self configCustomCoverViewAtIndex:pageIndex+1];
    
    if(pageIndex >= 0 && [self.urls count] ){
        if([self.delegate respondsToSelector:@selector(photoViewer:didShowPhotoAtIndex:)]){
            [self.delegate photoViewer:self didShowPhotoAtIndex:pageIndex];
        }
    }
}

- (void)pagingScrollView:(AFTPagingScrollView *)pagingScrollView didScrollToPageAtIndex:(NSInteger)pageIndex
{
    [self configCustomCoverViewAtIndex:pageIndex-1];
    [self configCustomCoverViewAtIndex:pageIndex];
    [self configCustomCoverViewAtIndex:pageIndex+1];
    
    if(pageIndex >= 0 && [self.urls count] ){
        if([self.delegate respondsToSelector:@selector(photoViewer:scrollToPageAtIndex:)]){
            [self.delegate photoViewer:self scrollToPageAtIndex:pageIndex];
        }
    }
}

#pragma mark - Private

- (void)configCustomCoverViewAtIndex:(NSInteger)pageIndex
{
    if( [self.urls count] == 0 || pageIndex > [self.urls count] || pageIndex < 0){
        return;
    }
    
    BOOL showCoverView = NO;
    if([self.delegate respondsToSelector:@selector(photoViewer:showCoverViewAtIndex:)]){
        showCoverView = [self.delegate photoViewer:self showCoverViewAtIndex:pageIndex];
    }
    
    AFTImageScrollView *page = [self.mainScrollView pageForIndex:pageIndex];
    if(!page){
        return;
    }
    
    page.customCoverView.hidden = !showCoverView;
    page.userInteractionEnabled = !showCoverView;
}

- (void)configLoadingStatusAtIndex:(NSInteger)pageIndex status:(ACPhotoViewerLoadingStatus)status
{
    AFTImageScrollView *page = [self.mainScrollView pageForIndex:pageIndex];
    
    if(!page)
        return;
    
    switch (status) {
        case ACPhotoViewerLoading:
            page.placeholderView.hidden = YES;
            [page.af_spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
            [page bringSubviewToFront:page.af_spinner];
            [page.af_spinner startAnimating];
            break;
        case ACPhotoViewerFailed:
            page.placeholderView.hidden = NO;
            [page.af_spinner stopAnimating];
            break;
        case ACPhotoViewerSuccess:
            page.placeholderView.hidden = YES;
            [page.af_spinner stopAnimating];
            break;
        default:
            break;
    }
}

- (void)downloadImageAtPageIndex:(NSInteger)pageIndex completion:(void (^)(BOOL success))completion{
    
    NSString *urlStr = [self.urls safelyObjectAtIndex:pageIndex];
    if(!urlStr){
        if(completion)completion(NO);
        return;;
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL)
    {
        if(image && !error){
            if(completion)completion(YES);
        }else{
            [self setInvalidUrl:urlStr];
            if(completion)completion(NO);
        }
    }];
}

-(BOOL)checkIfInvalidUrl:(NSString *)url{
    NSNumber *num =  [self.failedUrls safelyObjectForKey:url];
    if(num){
        return [num integerValue]>2; // Allow retry twice
    }
    return NO;
}

-(void)setInvalidUrl:(NSString *)url{
    NSNumber *num = [self.failedUrls safelyObjectForKey:url];
    num = @([num intValue] + 1);
    [self.failedUrls safelySetObject:num forKey:url];
}

#pragma mark - Public

- (void)reloadData
{
    [self.mainScrollView reloadData];
}

- (void)reloadWithUrls:(NSArray *)urls
{
    NSInteger i = [self currentIndex];
    self.urls = urls;
    [self.mainScrollView reloadData];
    [self showPageAtIndex:i];
}

- (void)showPageAtIndex:(NSInteger)index
{
    NSInteger count = [self.urls count];
    if (count== 0) {
        return;
    }
    index = MIN( MAX(0, index), count - 1);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mainScrollView displayPageAtIndex:index];
    });
}

- (NSInteger)currentIndex
{
    return self.mainScrollView.currentPageIndex;
}

- (NSInteger)numberOfPages
{
    return self.mainScrollView.numberOfPages;
}

#pragma mark - Setter & Getter

-(AFTPagingScrollView *)mainScrollView
{
    if(!_mainScrollView){
        _mainScrollView = ({
            AFTPagingScrollView *v = [[AFTPagingScrollView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
            v.backgroundColor = [UIColor clearColor];
            v;
        });
    }
    
    return _mainScrollView;
}
-(UIImage *)placeholderImage
{
    if(!_placeholderImage){
        _placeholderImage = ({
            CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
            UIColor *bgColor = [UIColor clearColor];
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
            [bgColor setFill];
            UIRectFill(rect);
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            image;
        });
    }
    
    return _placeholderImage;
}


@end
