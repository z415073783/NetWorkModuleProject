//
//  BaseNavigationController.h
//  NetWorkProject
//
//  Created by Zlm on 15-4-11.
//  Copyright (c) 2015年 zlm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController
{
    
    
    
}
@property(nonatomic)UIImage* tabbarTitleImage; //tabbar的标题显示图片
@property(nonatomic)NSString* tabbarTitle;//tabbar的标题
@property(nonatomic)UIFont* tabbarTitleFont;//标题font
@property(nonatomic)UIImage* tabbarSelectBackImage;//选中状态的背景图片

//设置一个统一格式的标题
-(void)setNavigationWithTitle:(NSString*)title Color:(UIColor*)color;
//添加导航栏左侧按钮(默认样式)
-(void)setReturnButtonWithDefault;
//设置导航栏左侧按钮(自定义图片和触发方法)
-(void)addLeftButtonWithImagePath:(NSString*)path Action:(SEL)action;
//设置导航栏右侧按钮(自定义图片和触发方法)
-(void)setRightButtonWithImagePath:(NSString*)imagePath Action:(SEL)action;
//设置导航栏右侧按钮(自定义文字和触发方法)
-(void)setRightButtonWithTitle:(NSString*)title Action:(SEL)action;


@end
