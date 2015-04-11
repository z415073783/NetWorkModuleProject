//
//  SharedManage.h
//  New_Target
//
//  Created by Zlm on 14-9-1.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//  界面管理与网络管理

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NetWorkManage.h"
typedef NS_ENUM(NSInteger, PushNewLayerType)
{
    PUSHNEWLAYER_PUSH,
    PUSHNEWLAYER_PRESENT,
    PUSHNEWLAYER_PUSH_AND_REMOVETABBAR
    
}PUSHNEWLAYERTYPE;

@interface SharedManage : NSObject<NSURLConnectionDataDelegate>
{
@protected
    UIActivityIndicatorView* activityIndicator;
}
@property(nonatomic) id mainLayer;//当前TabbarController选中的baseNavigationViewCongroller
@property(nonatomic) id keyWindow;//主窗口
@property(nonatomic) UITabBarController* tabbarController;
@property(nonatomic) id currentLayer;//当前的ViewController
@property(nonatomic) NSString* textFont;//设置字体
+(SharedManage*)getInstance;

//推入新界面
-(id)openNewLayer:(UIViewController*)sender type:(PushNewLayerType)type   NS_AVAILABLE(10_9, NA); // 由BaseViewController自带回调函数替换
//返回主界面
-(void)popCurrentLayer:(BOOL)action NS_AVAILABLE(10_9, NA);// 由BaseViewController自带回调函数替换
-(void)dismissCurrentLayer:(BOOL)action NS_AVAILABLE(10_9, NA);// 由BaseViewController自带回调函数替换

//初始应用配置集成
/*
 font:默认字体
 keyWindow:注册窗口
 ipconfig:网络请求ip
 */
+(void)initApplicationconfigurationWithFont:(NSString*)font KeyWindow:(UIWindow*)window Ipconfig:(NSString*)ipconfig;
@end
