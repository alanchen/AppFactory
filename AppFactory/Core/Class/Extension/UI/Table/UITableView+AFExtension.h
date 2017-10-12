//
//  UITableView+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableView(AFExtension)

- (void)scrollToCellToVisible:(UITableViewCell *)cell animated:(BOOL)animated;
- (BOOL)isIndexPathValid:(NSIndexPath *)indexPath;

@end
