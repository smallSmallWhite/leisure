//
//  AppDelegate.m
//  Leisure
//
//  Created by xalo on 16/4/21.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "AppDelegate.h"
#import "DrawViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@interface AppDelegate () <RESideMenuDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    int i = [self monitorNetworking];
//    if (i == 1) {
//        
//        [self creadteAlerViewWithMessage:@"不是WIFI我不运行╭(╯^╰)╮哼~~"];
//        return NO;
//    }
//    else {
    
        [AVOSCloud setApplicationId:@"09bh6o2bsJsCIMayV6B169S4-gzGzoHsz" clientKey:@"yo2E5dCs3Mg7NWe62Bf46eOK"];
        
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[DrawViewController alloc] init]];
        LeftViewController *leftViewController = [[LeftViewController alloc] init];
        RightViewController *rightViewController = [[RightViewController alloc] init];
        
        RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController leftMenuViewController:leftViewController rightMenuViewController:rightViewController];
        sideMenuViewController.backgroundImage = [UIImage imageNamed:@"bz1.jpg"];
        sideMenuViewController.menuPreferredStatusBarStyle = 1;
        sideMenuViewController.delegate = self;
        sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
        sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
        sideMenuViewController.contentViewShadowOpacity = 0.6;
        sideMenuViewController.contentViewShadowRadius = 12;
        sideMenuViewController.contentViewShadowEnabled = YES;
        self.window.rootViewController = sideMenuViewController;
//    }
    return YES;
}

//设置网络监听
- (int)monitorNetworking
{
    //监听网络状态
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //显然是枚举值
    /*
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,//未识别的网络
     AFNetworkReachabilityStatusNotReachable     = 0,//不可达的网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,//2G,3G,4G...
     AFNetworkReachabilityStatusReachableViaWiFi = 2,//wifi网络
     */
    __block int i = 0;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown | AFNetworkReachabilityStatusReachableViaWWAN |  AFNetworkReachabilityStatusReachableViaWiFi:
                i = 0;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                i = 1;
                break;
            default:
                break;
        }
    }];
    
    //3.开始监听
    [manager startMonitoring];
    return i;
}

#pragma mark - 警示框
- (void)creadteAlerViewWithMessage:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"友情提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
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
