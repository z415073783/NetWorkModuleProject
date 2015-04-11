//
//  BaseTabbarController.m
//  ZLMStaticFramework
//
//  Created by Zlm on 15-3-31.
//  Copyright (c) 2015年 zlm. All rights reserved.
//

#import "BaseTabbarController.h"
#import "SharedManage.h"
#import "AdaptiveDeviceManage.h"
#import "BaseNavigationController.h"
@implementation BaseTabbarController
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.delegate = self;
        return self;
    }
    return nil;
}
-(void)viewDidLoad
{
    
}

-(void)setCustomViewControllers:(NSArray *)viewControllers
{
   
    [self setViewControllers:viewControllers];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[SharedManage getInstance] setMainLayer:[viewControllers objectAtIndex:0]];//注册视图

    [[SharedManage getInstance] setTabbarController:self];//注册视图

    for (int i = 0; i < [viewControllers count]; i++)
    {
        BaseNavigationController* selectNC = [viewControllers objectAtIndex:i];
        UIImageView* background = [[UIImageView alloc]initWithImage:selectNC.tabbarSelectBackImage];
        [background setFrame:CGRectMake(0, 0, [AdaptiveDeviceManage ZZCurrentDeviceWithWidth]/[viewControllers count], 49)];
        [background setCenter:ZZPoint_Foot(CGPointMake(background.frame.size.width/2+i*background.frame.size.width, 476))];
        
        if (i != 0)
        {
            background.hidden = YES;
        }
        background.tag = 900827+i;
        [self.view addSubview:background];
        
        if (selectNC.tabbarTitleImage)
        {
            UIImageView* backImage = [[UIImageView alloc]initWithImage:selectNC.tabbarTitleImage];
            [backImage setCenter:ZZPoint_Foot(CGPointMake(background.frame.size.width/2+i*background.frame.size.width, 468))];
            [self.view addSubview:backImage];
        }
        
        UILabel* backTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
        backTitle.text = selectNC.tabbarTitle;
        [backTitle setCenter:ZZPoint_Foot(CGPointMake(background.frame.size.width/2+i*background.frame.size.width, 489))];
        [backTitle setBackgroundColor:[UIColor clearColor]];
        [backTitle setTextAlignment:NSTextAlignmentCenter];
        [backTitle setFont:selectNC.tabbarTitleFont];
        NSLog(@"%@",selectNC.tabbarTitleFont);
        [backTitle setTextColor:[UIColor whiteColor]];
        [self.view addSubview:backTitle];
    }
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    [[SharedManage getInstance] setMainLayer:viewController];
    
    for (int i = 0; i < [self.viewControllers count]; i++)
    {
        if (i == tabBarController.selectedIndex)
        {
            [tabBarController.view viewWithTag:900827+i].hidden = NO;
        }else
        {
            [tabBarController.view viewWithTag:900827+i].hidden = YES;
        }
    }
    if (_zDelegate)
    {
        [_zDelegate tabBarController:self didSelectViewController:viewController];
    }
}
-(void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    if (_zDelegate)
    {
        [_zDelegate tabBarController:self didEndCustomizingViewControllers:viewControllers changed:changed];
    }
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (_zDelegate)
    {
        return [_zDelegate tabBarController:self shouldSelectViewController:viewController];
    }
    return YES;
}
-(void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{
    if (_zDelegate)
    {
        [_zDelegate tabBarController:self willBeginCustomizingViewControllers:viewControllers];
    }
}
-(void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    if (_zDelegate)
    {
        [_zDelegate tabBarController:self willEndCustomizingViewControllers:viewControllers changed:changed];
    }
}


@end
