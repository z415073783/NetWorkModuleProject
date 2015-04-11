//
//  AppDelegate.m
//  NetWorkProject
//
//  Created by Zlm on 15-4-10.
//  Copyright (c) 2015年 zlm. All rights reserved.
//

#import "AppDelegate.h"
#import "NetWorkManage.h"

#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "SharedManage.h"
#import "AdaptiveDeviceManage.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
     [self.window makeKeyAndVisible];
    //初始化配置
    [SharedManage initApplicationconfigurationWithFont:@"Helvetica" KeyWindow:self.window Ipconfig:@"192.168.0.27:8081"];

    BaseTabbarController* testTabbarC = [[BaseTabbarController alloc]init];
    
    NSMutableArray* viewNCArray = [NSMutableArray array];
    NSArray* nameArr = [NSArray arrayWithObjects:@"鲜职",@"良练",@"花样",@"知青",@"鲜职", nil];
    for (int i = 0; i<[nameArr count]; i++)
    {
        BaseViewController* viewC = [[BaseViewController alloc]init];
        BaseNavigationController* viewNC = [[BaseNavigationController alloc]initWithRootViewController:viewC];
        [viewNC setTabbarTitle:[nameArr objectAtIndex:i]];
        [viewNC setTabbarTitleFont:[UIFont fontWithName:[SharedManage getInstance].textFont size:12]];
        [viewNC setTabbarTitleImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[nameArr objectAtIndex:i]]]];
        [viewNC setTabbarSelectBackImage:[UIImage imageNamed:@"1b.png"]];
        [viewNC.navigationBar setBackgroundImage:[UIImage imageNamed:@"底栏64.png"] forBarMetrics:UIBarMetricsDefault];
        [viewNCArray addObject:viewNC];
        [viewNC setNavigationWithTitle:@"公职通" Color:[UIColor blueColor]];
        NSLog(@"%@",viewNC.tabbarTitleFont);
    }
    [testTabbarC setCustomViewControllers:viewNCArray];
    [testTabbarC setZDelegate:self];
    
    self.window.rootViewController = testTabbarC;
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"底栏.png"]];
    
//    NSLog(@"%@",[UIFont familyNames]);
    
    return YES;
}
-(BOOL)tabBarController:(BaseTabbarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}
-(void)tabBarController:(BaseTabbarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
