//
//  BaseViewController.m
//  ModuleProject
//
//  Created by Zlm on 14-11-18.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import "BaseViewController.h"
#import "SharedManage.h"
@implementation BaseViewController
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}
#pragma mark - 设置标题 -
-(void)setNavigationWithTitle:(NSString*)title Color:(UIColor*)color
{
    UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    titleLabel.text = title;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:[[SharedManage getInstance] textFont]  size:20];
    titleLabel.textColor = color;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationController.topViewController.navigationItem.titleView = titleLabel;
}

#pragma mark - 设置导航栏左侧按钮(默认) -
-(void)setReturnButtonWithDefault
{
    UIBarButtonItem* leftButton;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        
        leftButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(returnRootView:Action:)];
        leftButton.tintColor = [UIColor whiteColor];
        
    }else
    {
        UIButton* zButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [zButton setImage:[UIImage imageNamed:@"Resource/UIImage/GeneralImage/return_Button.png"] forState:UIControlStateNormal];
        [zButton addTarget:self action:@selector(returnRootView:Action:) forControlEvents:UIControlEventTouchUpInside];
        [zButton setFrame:CGRectMake(0, 0, 44, 43)];
        leftButton = [[UIBarButtonItem alloc]initWithCustomView:zButton];
    }
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = leftButton;
}
#pragma mark - 设置导航栏左侧按钮(自定义) -
-(void)addLeftButtonWithImagePath:(NSString*)path Action:(SEL)action
{
    UIButton* zButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [zButton setImage:[UIImage imageNamed:path] forState:UIControlStateNormal];
    [zButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [zButton setFrame:CGRectMake(0, 0, [UIImage imageNamed:path].size.width, [UIImage imageNamed:path].size.height)];
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc]initWithCustomView:zButton];
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = rightButton;
}
-(void)returnRootView:(id)sender Action:(BOOL)action
{
    [self.navigationController popViewControllerAnimated:action];
}
#pragma mark - 设置导航栏右侧按钮(图片) -
-(void)setRightButtonWithImagePath:(NSString*)imagePath Action:(SEL)action
{
//    UIViewController* view = sender;
    UIButton* zButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [zButton setImage:[UIImage imageNamed:imagePath] forState:UIControlStateNormal];
    [zButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [zButton setFrame:CGRectMake(0, 0, [UIImage imageNamed:imagePath].size.width, [UIImage imageNamed:imagePath].size.height)];
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc]initWithCustomView:zButton];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = rightButton;
}
#pragma mark - 设置导航栏右侧按钮(文字) -
-(void)setRightButtonWithTitle:(NSString*)title action:(SEL)action
{
    UIButton* zButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [zButton setTitle:title forState:UIControlStateNormal];
    zButton.frame = CGRectMake(0, 0, 40, 40);
    [zButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [zButton setTitleColor:[UIColor colorWithRed:0.1 green:0.8 blue:1 alpha:1] forState:UIControlStateNormal];
    [zButton setTitleColor:[UIColor colorWithRed:0.1 green:0.8 blue:1 alpha:0.4] forState:UIControlStateHighlighted];
    
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:zButton];
    
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = rightBarButton;
}
-(void)pushBaseViewControllerAnimated:(BOOL)animated
{
    [[SharedManage getInstance].mainLayer pushViewController:self animated:animated];
}
-(void)presentBaseViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [[SharedManage getInstance].mainLayer presentViewController:self animated:animated completion:^{
        completion();
    }];
}
-(void)popToBaseRootViewControllerAnimated:(BOOL)animated
{
    [[SharedManage getInstance].mainLayer popToRootViewControllerAnimated:YES];
}
-(void)dismissBaseViewControllerAnimated:(BOOL)animated completion:(void (^)(void))block
{
    [[SharedManage getInstance].mainLayer dismissViewControllerAnimated:animated completion:^{
        block();
    }];
}

@end
