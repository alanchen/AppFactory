//
//  NSString+AFRegExtension.m
//  AppFactory
//
//  Created by alan on 2017/9/27.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "NSString+AFRegExtension.h"

@implementation NSString(AFRegExtension)

- (BOOL)isValidEmail
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidUrl
{
    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlPredic = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    BOOL isValidURL = [urlPredic evaluateWithObject:self];
    return isValidURL;
}

- (BOOL) isAllDigits
{
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [self rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound;
}

-(void)findMatchesRegex:(NSString *)regexString enumBlock:(void (^)(NSRange matchRange))enumBlock
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                           options:NSRegularExpressionUseUnicodeWordBoundaries
                                                                             error:nil];
    
    NSArray *matches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    for (NSTextCheckingResult * result in matches) {
        NSRange matchRange = [result range];
        enumBlock(matchRange);
    }
    
}

-(void)findLinksWithEnumBlock:(void (^)(NSRange matchRange, NSString *link))enumBlock
{
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [detector matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    for (NSTextCheckingResult * match in matches) {
        NSRange matchRange = [match range];
        NSString *subString = [self substringWithRange:matchRange];
        enumBlock(matchRange, subString?subString:@"");
    }
}

@end
