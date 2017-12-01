//
//  AFAppVersonHelper.h
//  AppFactory
//
//  Created by alan on 2017/10/6.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFAppVersonHelper : NSObject

+(AFAppVersonHelper *)sharedInstance;

- (void)performVersionCheck;

- (void)launchAppStore;

- (NSString *)appStoreVersion;

/**
 *  @return YES if it will show.
 */
+ (BOOL)showAndCheckVersionWithTitle:(NSString *)title
                             message:(NSString *)message
                             goTitle:(NSString *)goTitle
                        nextimeTitle:(NSString *)nextimeTitle
                         serverBuild:(NSInteger )serverBuildNumber
                   serverBuildForced:(NSInteger )serverBuildNumberForce
                        forcedUpdate:(void (^)(void))forcedBlock
                      optionalUpdate:(void (^)(void))optionalBlock
                      nextTimeUpdate:(void (^)(void))nextTimeBlock;


@end
