//
//  AnyPromise+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/17.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PromiseKit/PromiseKit.h>

typedef void (^ thenPromiseBlock)(PMKResolver, id);

@interface AnyPromise(AFExtension)

+ (AnyPromise *)promiseStart:(void (^)(PMKResolver))block;
- (AnyPromise * (^)(thenPromiseBlock))thenWithANewPromise;

@end

//[AnyPromise promiseStart:^(PMKResolver resolve){
//    resolve(@"123");
//}].thenWithANewPromise(^(PMKResolver resolve, id data){
//    @throw [NSError errorWithDomain:@"fb.sso.helper123" code:99 userInfo:nil];
//    resolve(@"456");
//}).thenWithANewPromise(^(PMKResolver resolve, id data){
//    resolve(@"789");
//}).catch(^(NSError *err){
//
//});

