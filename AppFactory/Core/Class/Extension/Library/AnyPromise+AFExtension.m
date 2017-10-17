//
//  AnyPromise+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/17.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AnyPromise+AFExtension.h"

@implementation AnyPromise(AFExtension)

+ (AnyPromise *)promiseStart:(void (^)(PMKResolver))block
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        resolve(nil);
    }].thenWithANewPromise(^(PMKResolver resolve, id data){
        if(block){ block(resolve); }
    });
}

- (AnyPromise * (^)(thenPromiseBlock))thenWithANewPromise {
    __weak AnyPromise *weakSelf = self;
    
    return ^(thenPromiseBlock block){
        return weakSelf.then(^(id data){
            return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
                if(block){ block(resolve, data); }
            }];
        });
    };
}

@end
