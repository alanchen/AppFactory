//
//  UITableView+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UITableView+AFExtension.h"
#import "LibsHeader.h"

@implementation UITableView(AFExtension)

- (void)scrollToCellToVisible:(UITableViewCell *)cell animated:(BOOL)animated
{
    @weakify(self);
    [self bk_performBlock:^(id obj) {
        @strongify(self);
        [self scrollRectToVisible:[self convertRect:cell.bounds fromView:cell] animated:YES];
    } afterDelay:0.1];
}

-(BOOL)isIndexPathValid:(NSIndexPath *)indexPath
{
    if (indexPath.section >= [self numberOfSections] ){
        return NO;
    }
    
    if (indexPath.row >= [self numberOfRowsInSection:indexPath.section] ){
        return NO;
    }
    
    return YES;
}

@end
