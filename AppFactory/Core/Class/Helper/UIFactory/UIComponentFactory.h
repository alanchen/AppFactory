//
//  UIComponentFactory.h
//
//  Created by alan on 2017/7/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIComponentFactory : NSObject

/////////////////////////////////////////
//              Button
/////////////////////////////////////////

+ (UIButton *)button;

+ (UIButton *)buttonWithFilledColor:(UIColor *)color roundDiameter:(CGFloat)diameter;


/////////////////////////////////////////
//              Label
/////////////////////////////////////////

+ (UILabel *)labelWithFont:(UIFont *)font;

/////////////////////////////////////////
//             ImageView
/////////////////////////////////////////

+ (UIImageView *)imageViewWithName:(NSString *)imgName;

+ (UIImageView *)imageViewRoundedWithSize:(float)whSize;


/////////////////////////////////////////
//              Others
/////////////////////////////////////////

+ (UITextField *)textFieldWithRoundBoarder;

+ (UITextField *)textField;

+ (UIView *)lineForinputAccessoryView;     // put in - (BOOL)textFieldShouldBeginEditing:(UITextField *)textField

+ (UIActivityIndicatorView *)spinner;

/////////////////////////////////////////
//           UIBarButtonItem
/////////////////////////////////////////

+ (UIBarButtonItem *) barButtonItemWithImageName:(NSString *)name
                                         target: (id)target
                                         action:(SEL)action;

+ (UIBarButtonItem *) barButtonItemWithCustomeViewImageName: (NSString *)name
                                                     target: (id)target
                                                     action: (SEL)action;

+ (UIBarButtonItem *) barButtonItemWithTitle:(NSString *)name
                                      target: (id)target
                                      action:(SEL)action;



@end
