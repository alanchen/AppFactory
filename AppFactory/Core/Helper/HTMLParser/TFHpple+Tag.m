//
//  TFHpple+Tag.m
//  PigMarket
//
//  Created by alan on 2017/6/1.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "TFHpple+Tag.h"

@implementation TFHpple(Tag)

-(NSString *)headTitle
{
    TFHppleElement *element =  [self peekAtSearchWithXPathQuery:@"//head/title"];
    return element.text;
}

-(NSString *)headDescription
{
    TFHppleElement *element =  [self peekAtSearchWithXPathQuery:@"//head/meta[@name='description']"];
    return [element objectForKey:@"content"];
}

-(NSString *)ogDescription
{
    TFHppleElement *element =  [self peekAtSearchWithXPathQuery:@"//head/meta[@property='og:description']"];
    return [element objectForKey:@"content"];
}

-(NSString *)ogTitle
{
    TFHppleElement *element =  [self peekAtSearchWithXPathQuery:@"//head/meta[@property='og:title']"];
    return [element objectForKey:@"content"];
}

-(NSString *)ogImage
{
    TFHppleElement *element =  [self peekAtSearchWithXPathQuery:@"//head/meta[@property='og:image']"];
    return [element objectForKey:@"content"];
}

-(NSString *)googleDescription
{
    TFHppleElement *element =  [self peekAtSearchWithXPathQuery:@"//head/meta[@itemprop='description']"];
    return [element objectForKey:@"content"];
}

-(NSString *)googleTitle
{
    TFHppleElement *element =  [self peekAtSearchWithXPathQuery:@"//head/meta[@itemprop='name']"];
    return [element objectForKey:@"content"];
}

-(NSString *)googleImage
{
    TFHppleElement *element =  [self peekAtSearchWithXPathQuery:@"//head/meta[@itemprop='image']"];
    return [element objectForKey:@"content"];
}

-(NSString *)twitterDescription
{
    TFHppleElement *element =  [self peekAtSearchWithXPathQuery:@"//head/meta[@name='twitter:description']"];
    return [element objectForKey:@"content"];
}

-(NSString *)twitteTitle
{
    TFHppleElement *element =  [self peekAtSearchWithXPathQuery:@"//head/meta[@name='twitter:title']"];
    return [element objectForKey:@"content"];
}

-(NSString *)twitteImage
{
    TFHppleElement *element =  [self peekAtSearchWithXPathQuery:@"//head/meta[@name='twitter:image:src']"];
    return [element objectForKey:@"content"];
}

-(NSString *)titleWithUrl:(NSString *)url
{
    NSString *result = [self headTitle];
    
    if(!result){
        result = [self googleTitle];
        if(!result){
            result = [self ogTitle];
            if(!result){
                result = [self twitteTitle];
            }
        }
    }
    
    if(!result){
        result = url;
    }
    
    return result;
}

-(NSString *)imageUrlWithBaseUrl:(NSString *)baseUrl
{
    NSString *result = [self ogImage];
    
    if(!result){
        result = [self ogImage];
        if(!result){
            result = [self googleImage];
            if(!result){
                result = [self twitteImage];
            }
        }
    }
    
    if(![result hasPrefix:@"http"] && result){
        result = [NSString stringWithFormat:@"%@%@",baseUrl,result];
    }
    
    return result;
}

-(NSString *)descriptionWithUrl:(NSString *)url
{
    NSString *result = [self headDescription];
    
    if(!result){
       result = [self googleDescription];
        if(!result){
            result = [self ogDescription];
            if(!result){
                result = [self twitteTitle];
            }
        }
    }
    
    if(!result){
        result = url;
    }
    
    return result;
}

@end
