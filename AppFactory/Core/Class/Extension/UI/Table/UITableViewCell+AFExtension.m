//
//  UITableViewCell+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UITableViewCell+AFExtension.h"
#import "LibsHeader.h"

@implementation UITableViewCell(AFExtension)

- (CGFloat) contentW
{
    return self.contentView.width;
}

- (CGFloat) contentH
{
    return self.contentView.height;
}

- (CGFloat) contentCenterY
{
    return self.contentView.height/2;
}

- (CGFloat) contentCenterX
{
    return self.contentView.width/2;
}

@end
