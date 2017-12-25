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
    NSString *schemeLowercaseString = [self.scheme lowercaseString];
    BOOL isHttpsScheme = [schemeLowercaseString containsString:@"https"];
    BOOL isHttpScheme = [schemeLowercaseString containsString:@"http"];
    
    if(isHttpsScheme || isHttpScheme){
        NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
        components.scheme = isHttpsScheme ? @"https" : @"http";
        NSURL *url = components.URL;
        if(!url){ return [NSURL URLWithString:@"http://"];}
        return components.URL;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.absoluteString]];
    return url;
}

@end
