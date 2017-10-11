//
//  NSURL+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "NSURL+AFExtension.h"

@implementation NSURL(AFExtension)

+ (NSURL *)urlByValidationWithString:(NSString *)string
{
    NSMutableCharacterSet *myAllowedCharacterSet = [NSMutableCharacterSet characterSetWithCharactersInString:@"#"];
    [myAllowedCharacterSet formUnionWithCharacterSet:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *decodedURLString = string.stringByRemovingPercentEncoding;
    NSString *encodedURLString = [decodedURLString stringByAddingPercentEncodingWithAllowedCharacters:myAllowedCharacterSet];
    NSURL *url = [NSURL URLWithString:encodedURLString];
   
    return url;
}

- (NSURL *)urlByAddingValidHTTPSchemeIfNeed
{
    BOOL isHttpScheme = [[self.scheme lowercaseString] containsString:@"http"]||[self.scheme containsString:@"https"];
    
    if(isHttpScheme)
        return self;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.absoluteString]];
    return url;
}

@end
