//
//  UIImage+NYXResize.h
//  AppFactory
//
//  Created by Alan on 2022/5/9.
//  Copyright © 2022 alan. All rights reserved.
//

// This is UIImage+Resizing.h in NYXImagesKit
// NYXImagesKit is deprecated

#import <UIKit/UIKit.h>

@interface UIImage(NYXResize)

-(UIImage*)scaleToFitSize:(CGSize)newSize;
-(UIImage*)scaleToFillSize:(CGSize)newSizel;

@end

