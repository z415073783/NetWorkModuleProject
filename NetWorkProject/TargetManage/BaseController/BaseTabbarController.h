//
//  BaseTabbarController.h
//  ZLMStaticFramework
//
//  Created by Zlm on 15-3-31.
//  Copyright (c) 2015年 zlm. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BaseTabbarControllerDelegate;

@interface BaseTabbarController : UITabBarController<UITabBarControllerDelegate>
{
    
    
}
@property(nonatomic,assign) id<BaseTabbarControllerDelegate> zDelegate;

-(void)setCustomViewControllers:(NSArray *)viewControllers;

@end


@protocol BaseTabbarControllerDelegate
@required
- (BOOL)tabBarController:(BaseTabbarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
@optional
- (void)tabBarController:(BaseTabbarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(BaseTabbarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers;
- (void)tabBarController:(BaseTabbarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed NS_AVAILABLE_IOS(3_0);
- (void)tabBarController:(BaseTabbarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed;
@end
