//
//  HTMLParser.h
//  PigMarket
//
//  Created by alan on 2017/5/31.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMLParserHeader : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *url;

@end


@interface HTMLParser : NSObject

+(void)loadUrl:(NSString *)url headInfo:(void (^)(HTMLParserHeader *info))block;

@end
