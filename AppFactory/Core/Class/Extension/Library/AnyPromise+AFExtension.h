//
//  AnyPromise+AFExtension.h
//  AppFactory
//
//  Created by alan on 2017/10/17.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PromiseKit/PromiseKit.h>

@interface AnyPromise(AFExtension)

-(AnyPromise *)af_thenWithANewPromise:(void (^)(PMKResolver resolve, id data))block;

@end
