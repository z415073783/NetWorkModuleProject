//
//  UIButton+BaseButton.m
//  ModuleProject
//
//  Created by Zlm on 14-11-18.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import "UIButton+BaseButton.h"

@implementation UIButton (BaseButton)
+(UIButton*)buttonSetAllPropertyWithTitle:(NSString*)title Font:(UIFont*)font ImagePath:(NSString*)imagePath Frame:(CGRect)frame Select:(SEL)action Target:(NSObject*)target BarkGroundColor:(UIColor*)color
{
    UIButton* appointButton = [UIButton buttonWithType:UIButtonTypeCustom];
    appointButton.frame = frame;
    if (imagePath)
    {
        [appointButton setImage:[UIImage imageNamed:imagePath] forState:UIControlStateNormal];
    }
    [appointButton setTitle:title forState:UIControlStateNormal];
    appointButton.titleLabel.font = font;
    [appointButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (color)
    {
        appointButton.backgroundColor = color;
    }
    return appointButton;
}

@end
