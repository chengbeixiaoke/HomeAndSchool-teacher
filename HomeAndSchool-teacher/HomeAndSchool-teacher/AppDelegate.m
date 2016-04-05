//
//  AppDelegate.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "AppDelegate.h"
#import "homeViewController.h"
#import "friendViewController.h"
#import "chatViewController.h"
#import "myCenterViewController.h"
#import "Define.h"
#import <RongIMKit/RongIMKit.h>
@interface AppDelegate ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    homeViewController *HomeVc = [[homeViewController alloc]init];
    UINavigationController *nvc1 = [[UINavigationController alloc]initWithRootViewController:HomeVc];
    nvc1.tabBarItem.title = @"首页";
    nvc1.tabBarItem.image = [UIImage imageNamed:@"homePic"];
    
    friendViewController *FriendVc = [[friendViewController alloc]init];
    UINavigationController *nvc2 = [[UINavigationController alloc]initWithRootViewController:FriendVc];
    nvc2.tabBarItem.title = @"好友";
    nvc2.tabBarItem.image = [UIImage imageNamed:@"chatPic"];
    
    chatViewController *ChatVc = [[chatViewController alloc]init];
    UINavigationController *nvc3 = [[UINavigationController alloc]initWithRootViewController:ChatVc];
    nvc3.tabBarItem.title = @"消息";
    nvc3.tabBarItem.image = [UIImage imageNamed:@"friendPic"];
    
    
    myCenterViewController *MeVc = [[myCenterViewController alloc]init];
    UINavigationController *nvc4 = [[UINavigationController alloc]initWithRootViewController:MeVc];
    MeVc.tabBarItem.title = @"我的";
    MeVc.tabBarItem.image = [UIImage imageNamed:@"mePic"];
    
    
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    //改变tabBar的背景颜色
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    //改变点击后的颜色
    [[UITabBar appearance] setTintColor:COLOR(46, 184, 245, 1)];
    
    tabBar.viewControllers = @[nvc1, nvc3, nvc2, nvc4];
    
    self.window.rootViewController = tabBar;
    
    [[UINavigationBar appearance] setBarTintColor:COLOR(46, 184, 245, 1)];
    
    
    [self.window makeKeyAndVisible];

    //注册聊天
    
    [[RCIM sharedRCIM]setUserInfoDataSource:self];
    
    [[RCIM sharedRCIM] setGroupInfoDataSource:self];

    
    [[RCIM sharedRCIM] initWithAppKey:RONGYUN_KEY];
    
    [[RCIM sharedRCIM]connectWithToken:TOKEN success:^(NSString *userId) {
        
        NSLog(@"%@登陆成功",userId);
    } error:^(RCConnectErrorCode status) {

        
        NSLog(@"登录失败,错误代码为:%ld",(long)status);
    } tokenIncorrect:^{
        
        NSLog(@"token错误");
    }];
    

    return YES;
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


#pragma mark 用户信息回调


- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion{
    
    
    if ([@"666" isEqual:groupId]) {
        RCGroup *group = [[RCGroup alloc]init];
        group.groupId = @"666";
        group.groupName = @"信计二班";
        group.portraitUri = @"http://www.3761.com/uploads/attachments/image/2015-08/20150807090857_39883.jpg";
        
        
        return completion(group);
        
    }
    
    return completion(nil);
}



- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    
    
    
    //举例
    if ([@"1122334" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"1122334";
        user.name = @"韩梅梅";
        user.portraitUri = @"http://img0.pconline.com.cn/pconline/1508/12/6819239_001_thumb.jpg";
        
        
        return completion(user);
        
    }else if ([@"11223344" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"11223344";
        user.name = @"王小明";
        user.portraitUri = @"http://img1.3lian.com/2015/gif/w2/26/101.jpg";
        
        
        
        return completion(user);
        
        
    }else  if ([@"18790591074" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"18790591074";
        user.name = @"盖哥";
        user.portraitUri = @"http://p7.qhimg.com/dr/250_500_/t019aa8b069d4994bd3.jpg";
        return completion(user);
        
    }else if  ([@"1583066886" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"1583066886";
        user.name = @"小黑";
        user.portraitUri = @"http://img4q.duitang.com/uploads/item/201411/18/20141118192934_tyUW8.thumb.224_0.jpeg";
        return completion(user);
    }

    
    
    return completion(nil);
    
    
}



@end
