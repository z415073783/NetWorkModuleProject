//
//  AdaptiveDeviceManage.h
//  ModuleProject
//
//  Created by Zlm on 14-11-18.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AdaptiveDeviceManage : NSObject
//extern
//全屏拉伸
CGRect ZZRectMakeWithAuto(CGRect sender);

//坐标全屏适配
CGPoint ZZPoint_Full(CGPoint sender);
//坐标沿底部高度适配
CGPoint ZZPoint_Foot(CGPoint sender);
//沿顶部高度
CGPoint ZZPoint_Top(CGPoint sender);
//居中
CGPoint ZZPoint_Center(CGPoint sender);

CGSize ZZSize_Full(CGSize sender);

CGSize ZZSize_AddSize(CGSize sender);
//底部高度
CGSize ZZSize_Foot(CGSize sender);
//顶部高度
CGSize ZZSize_Top(CGSize sender);
//原尺寸
CGSize ZZSize_Center(CGSize sender);


//获取当前设备大小
+(CGSize)ZZCurrentDeviceSize;
//获取当前设备宽度
+(float)ZZCurrentDeviceWithWidth;
//获取当前设备高度
+(float)ZZCurrentDeviceWithHeight;
//配置app适配策略
+(void)setConfiguration;

@end
