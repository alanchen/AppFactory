//
//  CountryCodePicker.h
//  FreePoint
//
//  Created by alan on 2015/4/8.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CountryModel.h"

@interface CountryCodePicker : NSObject

-(void)printAllCountryModels;

-(NSMutableArray *)defaultCountries;

-(NSMutableArray *)countriesBySearchTerm:(NSString *)term;

-(CountryModel *)getCountryModelByCountryCode:(NSString *)code;

-(CountryModel *)userDefaultCountry;

@end
