//
//  NSUserDefualtsMacros.h
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#define NSUserDefaultsSaved [[NSUserDefaults standardUserDefaults] synchronize]

#define NSUserDefaultsSetObj(keyValue,objValue)[[NSUserDefaults standardUserDefaults] setObject:objValue forKey:keyValue]
#define NSUserDefaultsSetInt(keyValue,iValue) [[NSUserDefaults standardUserDefaults] setInteger:iValue forKey:keyValue]
#define NSUserDefaultsSetBool(keyValue,bValue) [[NSUserDefaults standardUserDefaults] setBool:bValue forKey:keyValue]

#define NSUserDefaultsGetBool(keyValue) [[NSUserDefaults standardUserDefaults] boolForKey:keyValue]
#define NSUserDefaultsGetObj(keyValue) [[NSUserDefaults standardUserDefaults] objectForKey:keyValue]
#define NSUserDefaultsGetInt(keyValue) [[NSUserDefaults standardUserDefaults] integerForKey:keyValue]
