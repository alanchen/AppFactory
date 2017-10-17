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

- (AnyPromise * (^)(thenPromiseBlock))thenWithANewPromise;

@end
