//
//  AnyPromise+AFExtension.m
//  AppFactory
//
//  Created by alan on 2017/10/17.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "AnyPromise+AFExtension.h"

@implementation AnyPromise(AFExtension)

-(AnyPromise *)af_thenWithANewPromise:(void (^)(PMKResolver, id))block{
    return self.then(^(id data){
        return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
            if(block){ block(resolve, data); }
        }];
    });
}

@end
