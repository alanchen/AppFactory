//
//  PMNotificationNumberView.m
//  PigMarket
//
//  Created by alan on 2015/8/4.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "NotificationNumberView.h"
#import "UIColor+AFExtension.h"
#import <Masonry/Masonry.h>
#import <ViewUtils/ViewUtils.h>
#import "UILabel+AFExtension.h"

@implementation NotificationNumberView

+(NotificationNumberView *)view
{
    NotificationNumberView *v = [[NotificationNumberView alloc] initWithFrame:CGRectZero];
    
    return v;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor hexRGBA:0xE41714];
        self.clipsToBounds = YES;
        self.hideWhenZero  = YES;
        self.circleRadius = 8;
        [self addSubview: self.numberLabel];
        [self setNumber:0];
    }
    
    return self;
}

-(void)setColor:(UIColor *)color
{
    self.backgroundColor = color;
    self.numberLabel.backgroundColor = color;
}

-(void)showN
{
    float diameter = self.circleRadius * 2;
    NSInteger fontSize = MAX(6, diameter - 6);
    UIFont *font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];

    self.numberLabel.font = font;
    self.numberLabel.text = [NSString stringWithFormat:@"N"];
    [self.numberLabel sizeToFitTheSize:CGSizeMake(100, diameter)];

    self.layer.cornerRadius = self.circleRadius;
    self.size = CGSizeMake(MAX(self.numberLabel.width + 10, diameter), diameter);
    self.numberLabel.center = CGPointMake(self.width/2, self.height/2);

    self.hidden = NO;
}

#pragma mark - Setter & Getter

-(void)setNumber:(NSInteger)number
{
    _number = number;

    float diameter = self.circleRadius * 2;
    NSInteger fontSize = MAX(8, diameter - 6);
    UIFont *font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];

    self.numberLabel.font = font;
    self.numberLabel.text = [NSString stringWithFormat:@"%zd",number];
    [self.numberLabel sizeToFitTheSize:CGSizeMake(200, diameter)];

    self.layer.cornerRadius = self.circleRadius;
    self.size = CGSizeMake(MAX(self.numberLabel.width + 10, diameter), diameter);
    self.numberLabel.center = CGPointMake(self.width/2, self.height/2);

    if(number <= 0)
        self.hidden = self.hideWhenZero;
    else
        self.hidden = NO;
}

-(UILabel *)numberLabel
{
    if(!_numberLabel){
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.backgroundColor = self.backgroundColor;
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.font = [UIFont systemFontOfSize:12];
        _numberLabel.numberOfLines = 1.0;
    }
    
    return _numberLabel;
}

-(void)setCircleRadius:(float)circleRadius
{
    _circleRadius = circleRadius;
    if (_circleRadius < 8) {
        _circleRadius = 8;
    }
}

@end
