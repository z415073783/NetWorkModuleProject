//
//  AdaptiveDeviceManage.m
//  ModuleProject
//
//  Created by Zlm on 14-11-18.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//  适配设备策略

#import "AdaptiveDeviceManage.h"
#define ZZWinWidthScale [AdaptiveDeviceManage ZZCurrentDeviceWithWidth]/320
#define ZZWinHeightScale [AdaptiveDeviceManage ZZCurrentDeviceWithHeight]/480
@implementation AdaptiveDeviceManage
//全屏拉伸
CGRect ZZRectMakeWithAuto(CGRect sender)
{
    CGRect newRect = CGRectMake(sender.origin.x*[AdaptiveDeviceManage ZZCurrentDeviceWithWidth]/320, sender.origin.y*[AdaptiveDeviceManage ZZCurrentDeviceWithHeight]/480, sender.size.width*[AdaptiveDeviceManage ZZCurrentDeviceWithWidth]/320, sender.size.height*[AdaptiveDeviceManage ZZCurrentDeviceWithHeight]/480);
    return newRect;
}
//坐标全屏适配
CGPoint ZZPoint_Full(CGPoint sender)
{
    CGPoint newPoint = CGPointMake(sender.x*[AdaptiveDeviceManage ZZCurrentDeviceWithWidth]/320, sender.y*[AdaptiveDeviceManage ZZCurrentDeviceWithHeight]/480);
    return newPoint;
}
//坐标沿底部高度适配
CGPoint ZZPoint_Foot(CGPoint sender)
{
    CGPoint newPoint = CGPointMake(sender.x*[AdaptiveDeviceManage ZZCurrentDeviceWithWidth]/320, sender.y+[AdaptiveDeviceManage ZZCurrentDeviceWithHeight]-480);
    return newPoint;
}
//沿顶部高度
CGPoint ZZPoint_Top(CGPoint sender)
{
    CGPoint newPoint = CGPointMake(sender.x*[AdaptiveDeviceManage ZZCurrentDeviceWithWidth]/320, sender.y);
    return newPoint;
}
//居中
CGPoint ZZPoint_Center(CGPoint sender)
{
    return CGPointMake(sender.x+([AdaptiveDeviceManage ZZCurrentDeviceWithWidth]-320)/2,sender.y+([AdaptiveDeviceManage ZZCurrentDeviceWithHeight]-480)/2);
}

CGSize ZZSize_Full(CGSize sender)
{
    return CGSizeMake(sender.width*ZZWinWidthScale,sender.height);
}
CGSize ZZSize_AddSize(CGSize sender)
{
    return CGSizeMake(sender.width*ZZWinWidthScale ,sender.height+[AdaptiveDeviceManage ZZCurrentDeviceWithHeight]-480);
}
CGSize ZZSize_Foot(CGSize sender)
{
    return CGSizeMake(sender.width*ZZWinWidthScale,sender.height);
}
CGSize ZZSize_Top(CGSize sender)
{
    return CGSizeMake(sender.width*ZZWinWidthScale,([AdaptiveDeviceManage ZZCurrentDeviceWithHeight]-480)+sender.height);
}
CGSize ZZSize_Center(CGSize sender)
{
    return sender;
}

+(CGSize)ZZCurrentDeviceSize
{
    return CGSizeMake([AdaptiveDeviceManage ZZCurrentDeviceWithWidth], [AdaptiveDeviceManage ZZCurrentDeviceWithHeight]);
}
//获取当前设备宽度
+(float)ZZCurrentDeviceWithWidth
{
//    NSLog(@"%@",NSStringFromCGRect([[UIScreen mainScreen] applicationFrame]));
    return 320;
}
//获取当前设备高度
+(float)ZZCurrentDeviceWithHeight
{
    return [[UIScreen mainScreen] applicationFrame].size.height*(320/[[UIScreen mainScreen] applicationFrame].size.width);
}
+(void)setConfiguration
{
    [[[UIApplication sharedApplication]keyWindow] setContentScaleFactor:2.0f];
}
@end
