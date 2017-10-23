//
//  UIComponentFactory.m
//
//  Created by alan on 2017/7/10.
//  Copyright © 2017年 alan. All rights reserved.
//

#import "UIComponentFactory.h"
#import "UIButton+AFExtension.h"
#import "LibsHeader.h"

@implementation UIComponentFactory

/////////////////////////////////////////
//              Button
/////////////////////////////////////////

+ (UIButton *)button
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setClipsToBounds:YES];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    return  btn;
}

+ (UIButton *)buttonWithFilledColor:(UIColor *)color roundDiameter:(CGFloat)diameter
{
    UIButton *btn = [self button];
    if(color){
        [btn setBackgroundColor:color forState:UIControlStateNormal];
    }
    [btn setBackgroundColor:[UIColor colorWithHex:0xdddddd] forState:UIControlStateDisabled];
    [btn setBackgroundColor:[UIColor colorWithHex:0xdddddd] forState:UIControlStateHighlighted];
    [btn setFrame:CGRectMake(0, 0, 100, diameter)];
    btn.layer.cornerRadius = diameter/2;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return btn;
}

/////////////////////////////////////////
//              Label
/////////////////////////////////////////

+ (UILabel *)labelWithFont:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font =font;
    label.textColor = [UIColor colorWithHex:0x3d4544];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 1;
    
    return label;
}

/////////////////////////////////////////
//             ImageView
/////////////////////////////////////////

+ (UIImageView *)imageViewWithName:(NSString *)imgName
{
    UIImageView *v = [[UIImageView alloc] init];
    if(imgName){
        v.image = [UIImage imageNamed:imgName];
    }
    v.contentMode = UIViewContentModeScaleAspectFit;
//    [v.layer setMinificationFilter:kCAFilterTrilinear];
    return v;
}

+ (UIImageView *)imageViewRoundedWithSize:(float)whSize
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setSize:CGSizeMake(whSize, whSize)];
    imageView.layer.cornerRadius = whSize/2;
    imageView.backgroundColor = [UIColor colorWithHex:0xeeeeee];
    [imageView setClipsToBounds:YES];
    imageView.layer.borderWidth = 0.0;
    
    return imageView;
}


/////////////////////////////////////////
//              Others
/////////////////////////////////////////

+ (UITextField *)textFieldWithRoundBoarder
{
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectZero];
    [tf setBorderStyle:UITextBorderStyleLine];
    [tf setTextAlignment:NSTextAlignmentLeft];
    tf.layer.cornerRadius = 5.0;
    tf.layer.borderColor = [UIColor colorWithHex:0xDDDDDD].CGColor;
    tf.layer.borderWidth = 1.0;
    tf.clipsToBounds = YES;
    
    return tf;
}

+ (UITextField *)textField
{
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectZero];
    [tf setBorderStyle:UITextBorderStyleNone];
    [tf setTextAlignment:NSTextAlignmentLeft];
    tf.clipsToBounds = YES;
    
    return tf;
}

+ (UIView *)lineForinputAccessoryView
{
    CGFloat w = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat h = 1.0 / [UIScreen mainScreen].scale;
    
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    separatorView.backgroundColor = [UIColor lightGrayColor];
    
    return separatorView;
}

+ (UIActivityIndicatorView *)spinner
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.hidesWhenStopped = YES;
    [spinner stopAnimating];
    return spinner;
}

/////////////////////////////////////////
//           UIBarButtonItem
/////////////////////////////////////////

+ (UIBarButtonItem *) barButtonItemWithImageName: (NSString *)name
                                          target: (id)target
                                          action: (SEL)action
{
    if(!name){
        name = @"";
    }
    
    UIImage *img = [UIImage imageNamed:name];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:target action:action];
    return item;
}

+ (UIBarButtonItem *) barButtonItemWithCustomeViewImageName: (NSString *)name
                                                     target: (id)target
                                                     action: (SEL)action
{
    if(!name){
        name = @"";
    }
    
    UIImage *image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return item;
}

+ (UIBarButtonItem *) barButtonItemWithTitle:(NSString *)name
                                      target: (id)target
                                      action:(SEL)action
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:name style:UIBarButtonItemStylePlain target:target action:action];
    return item;
}



@end
