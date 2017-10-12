//
//  HTMLParser.m
//  PigMarket
//
//  Created by alan on 2017/5/31.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "HTMLParser.h"
#import "TFHpple+Tag.h"
#import "AFHTTPSessionManager+AFExtension.h"

@implementation HTMLParserHeader

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@", self.title, self.content, self.imageUrl];
}

@end

/////////////////////////////////////////

/////////////////////////////////////////

@implementation HTMLParser

+(void)loadUrl:(NSString *)url headInfo:(void (^)(HTMLParserHeader *info))block
{
    HTMLParser *p = [[HTMLParser alloc] init];
    [p loadHTMLUrl:url withCompletion:^(TFHpple *doc) {
        HTMLParserHeader *info = [[HTMLParserHeader alloc] init];
        info.url = url;
        if(!doc){
            if(block)
                block(info);
            return ;
        }
        
        info.title = [doc titleWithUrl:url];
        info.content = [doc descriptionWithUrl:url];
        info.imageUrl = [doc imageUrlWithBaseUrl:url];
        
        if(block)
            block(info);
    }];
}

-(void)loadHTMLUrl:(NSString *)url withCompletion:(void (^)(TFHpple *doc))block
{
    if(!url){
        block(nil);
        return;
    }
    
    if(![url length]){
        block(nil);
        return;
    }
    
    AFHTTPSessionManager *manager= [AFHTTPSessionManager newDefaultManager];
    
    NSString *ua = @"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36";
    [manager.requestSerializer setValue:ua forHTTPHeaderField:@"User-Agent"];
    manager.responseSerializer .acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 5;
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TFHpple *doc = [[TFHpple alloc] initWithHTMLData:responseObject];
        if(block){
            block(doc);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(block){
            block(nil);
        }
    }];
}

@end
