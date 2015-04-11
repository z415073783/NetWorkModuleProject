//
//  UIButton+BaseButton.h
//  ModuleProject
//
//  Created by Zlm on 14-11-18.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//按钮扩展

#import <UIKit/UIKit.h>

@interface UIButton (BaseButton)
//一次性设置按钮常用方法并返回
+(UIButton*)buttonSetAllPropertyWithTitle:(NSString*)title Font:(UIFont*)font ImagePath:(NSString*)imagePath Frame:(CGRect)frame Select:(SEL)action Target:(NSObject*)target BarkGroundColor:(UIColor*)color;
@end
