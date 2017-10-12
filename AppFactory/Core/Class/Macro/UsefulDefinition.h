//
//  UsefulDefinition.h
//  AppFactory
//
//  Created by alan on 2017/10/2.
//  Copyright © 2017年 alan. All rights reserved.
//

#define PERFORM_SELECTOR(target ,selector) if([target respondsToSelector:selector]){IMP imp = [target methodForSelector:selector];void (*func)(id, SEL) = (void *)imp;func(target, selector);}

#define INT2STR(x) [NSString stringWithFormat:@"%zd",x]
#define OBJSTR(obj) [NSString stringWithFormat:@"%@",obj]

#define IS_BETWEEN(value, min, max) (value < max && value > min)
#define IS_BETWEEN_EQUAL(value, min, max) ((value <= max) && (value >= min))

#define SIZE_ADD_WIDTH(size,value) CGSizeMake(size.width+value,size.height)
#define SIZE_ADD_HEIGHT(size,value) CGSizeMake(size.width,size.height+value)
#define SIZE_ADD(size1,size2) CGSizeMake(size1.width+size2.width,size1.height+size2.height)

#define RETURN_NONNULL(obj1,obj2) obj1?obj1:(obj2?obj2:nil)
#define NULL_TEST(obj1,obj2) obj1?obj1:obj2
#define CAST_TYPE(class,obj) ((class *)obj)

#define CHECK_SELECTOR_IF_VALID(obj,action) [obj respondsToSelector:@selector(action)]
#define RUN_SELECTOR_IF_VALID(obj,action) if([obj respondsToSelector:@selector(action)]){[obj action];}
#define RUN_SELECTOR_WITH_RETURN_VALUE_IF_VALID(obj,action,retVal) if([obj respondsToSelector:@selector(action)]){retVal=[obj action];}




