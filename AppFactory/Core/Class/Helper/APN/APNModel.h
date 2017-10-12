//
//  APNModel.h
//  AppFactory
//
//  Created by alan on 2017/10/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APNModel : NSObject

@property (nonatomic,strong) NSDictionary *userInfo;
@property (nonatomic,strong) NSDictionary *aps;
@property (nonatomic,strong) NSString *alert;
@property (nonatomic,strong) NSString *sound;
@property (nonatomic) NSInteger badge;
@property (nonatomic,strong) NSDictionary *payload;

+ (id)modelWithNotification:(NSDictionary *)userInfo;
- (id)initWithInfo:(id)info;

@end
