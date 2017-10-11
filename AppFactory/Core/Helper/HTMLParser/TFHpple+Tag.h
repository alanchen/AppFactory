//
//  TFHpple+Tag.h
//  PigMarket
//
//  Created by alan on 2017/6/1.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <hpple/TFHpple.h>

@interface TFHpple(Tag)

// http://www.oxxostudio.tw/articles/201406/social-meta.html

-(NSString *)headTitle;
-(NSString *)headDescription;

-(NSString *)ogDescription;
-(NSString *)ogTitle;
-(NSString *)ogImage;

-(NSString *)googleDescription;
-(NSString *)googleTitle;
-(NSString *)googleImage;

-(NSString *)twitterDescription;
-(NSString *)twitteTitle;
-(NSString *)twitteImage;

-(NSString *)titleWithUrl:(NSString *)url;
-(NSString *)imageUrlWithBaseUrl:(NSString *)baseUrl;
-(NSString *)descriptionWithUrl:(NSString *)url; // url is defualt value

@end
