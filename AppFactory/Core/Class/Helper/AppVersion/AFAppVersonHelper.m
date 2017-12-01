//
//  AFAppVersonHelper.m
//  AppFactory
//
//  Created by alan on 2017/10/6.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AFAppVersonHelper.h"
#import "DeviceMacros.h"
#import "UsefulDefinition.h"
#import "UIAlertController+AFExtension.h"

@interface AFAppVersonHelper()
@property (nonatomic,strong) id appData;
@property (nonatomic,strong) NSString *currentAppStoreVersion;
@property (nonatomic,strong) NSString *appId;
@end

@implementation AFAppVersonHelper

+(AFAppVersonHelper *)sharedInstance
{
    static AFAppVersonHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AFAppVersonHelper alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Private

- (void)parseResults:(NSData *)data
{
    _appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary<NSString *, id> *results = [self.appData valueForKey:@"results"];
        NSArray *versionsInAppStore = [results valueForKey:@"version"];
        if (versionsInAppStore) {
            if ([versionsInAppStore count]) {
                self.currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
            }
        }
        NSArray *trackIdsInAppStore = [results valueForKey:@"trackId"];
        if (trackIdsInAppStore) {
            if ([trackIdsInAppStore count]) {
                self.appId = [trackIdsInAppStore objectAtIndex:0];
            }
        }
    });
}

- (NSURL *)itunesURL
{
    NSURLComponents *components = [NSURLComponents new];
    components.scheme = @"https";
    components.host = @"itunes.apple.com";
    components.path = @"/lookup";
    
    NSString *bundleID =[NSBundle mainBundle].bundleIdentifier;
    NSMutableArray<NSURLQueryItem *> *items = [@[[NSURLQueryItem queryItemWithName:@"bundleId" value:bundleID]] mutableCopy];
    components.queryItems = items;
    
    return components.URL;
}

#pragma mark - Public

- (void)performVersionCheck
{
    NSURL *storeURL = [self itunesURL];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:storeURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if ([data length] > 0 && !error) { // Success
                                                    [self parseResults:data];
                                                }
                                            }];
    [task resume];
}

- (void)launchAppStore
{
    if(!self.appId || !self.currentAppStoreVersion){
        [[AFAppVersonHelper sharedInstance] performVersionCheck];
    }
    
    NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", self.appId];
    NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:iTunesURL options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:iTunesURL];
        }
    });
}

-(NSString *) appStoreVersion
{
    if(!self.appId || !self.currentAppStoreVersion){
        [[AFAppVersonHelper sharedInstance] performVersionCheck];
    }
    
    return _currentAppStoreVersion;
}

+ (BOOL)showAndCheckVersionWithTitle:(NSString *)title
                             message:(NSString *)message
                             goTitle:(NSString *)goTitle
                        nextimeTitle:(NSString *)nextimeTitle
                         serverBuild:(NSInteger )serverBuildNumber
                   serverBuildForced:(NSInteger )serverBuildNumberForce
                        forcedUpdate:(void (^)(void))forcedBlock
                      optionalUpdate:(void (^)(void))optionalBlock
                      nextTimeUpdate:(void (^)(void))nextTimeBlock
{
    
    if(![AFAppVersonHelper sharedInstance].appId || ![AFAppVersonHelper sharedInstance].currentAppStoreVersion){
        [[AFAppVersonHelper sharedInstance] performVersionCheck];
    }
    
    message = NULL_TEST(message, @"已有新版本，請至AppleStore更新！");
    goTitle = NULL_TEST(goTitle, @"前往更新");
    nextimeTitle = NULL_TEST(nextimeTitle, @"下次更新");

    NSInteger localBuildNumber = [INFO_BUILD_NUMBER integerValue];
    BOOL isForceUpdate = serverBuildNumberForce > localBuildNumber ;
    BOOL isOptionalUpdate = serverBuildNumber > localBuildNumber ;
    static BOOL isShowing = NO;
    if(isForceUpdate){
        if(!isShowing){
            isShowing = YES;
            [UIAlertController showWithTitle:title message:message buttonTitle:goTitle handler:^(UIAlertAction *action) {
                isShowing = NO;
                [[AFAppVersonHelper sharedInstance] launchAppStore];
                if(forcedBlock){ forcedBlock(); }
            }];
        }

        return YES;
    }

    if (isOptionalUpdate){
        if(!isShowing){
            isShowing = YES;
            [UIAlertController showAlertViewWithTitle:title message:message cancelTitle:nextimeTitle otherTitle:goTitle cancelHandler:^(UIAlertAction *action) {
                isShowing = NO;
                 if(nextTimeBlock){ nextTimeBlock(); }
            } otherHandler:^(UIAlertAction *action) {
                isShowing = NO;
                [[AFAppVersonHelper sharedInstance] launchAppStore];
                if(optionalBlock){ optionalBlock(); }
            }];
        }
        return YES;
    }

    return NO;
}

@end

