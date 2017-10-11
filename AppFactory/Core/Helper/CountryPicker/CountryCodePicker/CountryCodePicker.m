//
//  CountryCodePicker.m
//  FreePoint
//
//  Created by alan on 2015/4/8.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "CountryCodePicker.h"

@interface CountryCodePicker ()

@property (nonatomic,strong) NSMutableArray* countries;

@end

@implementation CountryCodePicker

- (id)init
{
    self = [super init];
    
    if (self)
    {
        NSLocale *locale = [NSLocale currentLocale];
        NSDictionary *countryJson = [self importCountryJson];
        
        self.countries = [NSMutableArray array];
        
        for(NSDictionary *cJson in countryJson)
        {
            NSString *countryCode = [cJson objectForKey:@"code"];
            NSString *dialCode = [cJson objectForKey:@"dial_code"];
            NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
            NSString *name = [cJson objectForKey:@"name"];
            
            if([dialCode isKindOfClass:[NSNull class]]){
                continue;
            }
            
            if([[dialCode componentsSeparatedByString:@" "] count]>=2){
                dialCode = [[dialCode componentsSeparatedByString:@" "] objectAtIndex:0];
            }
            
            CountryModel *country = [[CountryModel alloc] init];
            country.name = name;
            country.displayName = displayNameString;
            country.shortNameCode = countryCode;
            country.dialCode = dialCode;
            
            if([country.dialCode isEqualToString:@"+886"] || // tw
               [country.dialCode isEqualToString:@"+852"] || // hk
               [country.dialCode isEqualToString:@"+853"] || // macau
               [country.dialCode isEqualToString:@"+86"]  || // cn
               [country.dialCode isEqualToString:@"+65"]  || // sgp
               [country.dialCode isEqualToString:@"+60"]  || // marasiya
               [country.dialCode isEqualToString:@"+84"]  || // vienam
               [country.dialCode isEqualToString:@"+81"]  || // jp
               [country.dialCode isEqualToString:@"+91"]  || // india
               [country.dialCode isEqualToString:@"+63"]  || // phi
               [country.dialCode isEqualToString:@"+82"]  || // korea
               [country.dialCode isEqualToString:@"+66"]) {  // tai
                [self.countries addObject:country];
            }
        }
        
        self.countries = [[self.countries sortedArrayUsingComparator:^NSComparisonResult(CountryModel *obj1,
                                                                                         CountryModel *obj2){
                               return [obj1.name localizedCompare:obj2.name];}] mutableCopy];
        
    }
    
    return self;
}

-(NSDictionary *)importCountryJson
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
}

-(void)printAllCountryModels
{
//    for(CountryModel *country in self.countries){
//        DLog(@"%@ %@ %@",country.name,country.shortNameCode,country.dialCode);
//    }
}

-(NSMutableArray *)countriesBySearchTerm:(NSString *)term
{
    if(!term)
        return nil;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"displayName CONTAINS[c] %@ OR name CONTAINS[c] %@ OR shortNameCode CONTAINS[c] %@ OR dialCode CONTAINS[c] %@",term,term,term,term];
    NSArray *searchResults = [self.countries filteredArrayUsingPredicate:predicate];
    
    return [searchResults mutableCopy];
}

-(NSMutableArray *)defaultCountries
{
    return [self.countries mutableCopy];
}

-(CountryModel *)getCountryModelByCountryCode:(NSString *)code
{
    if(code == nil)
        return nil;
    
    for(CountryModel *country in self.countries){
        if([country.shortNameCode isEqualToString:code]){
            return country;
        }
    }
    
    return nil;
}

-(CountryModel *)userDefaultCountry
{
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    CountryModel *countryModel = [self getCountryModelByCountryCode:countryCode];
    
    if(countryModel==nil)
    {
       countryModel = [[CountryModel alloc] init];
       countryModel.name = @"Taiwan, Province of China";
       countryModel.displayName = @"台灣";
       countryModel.shortNameCode = @"TW";
       countryModel.dialCode = @"+886";
    }

    return countryModel;
}

@end

