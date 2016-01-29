//
//  AppDelegate.m
//  Xmpp
//
//  Created by Liu Zhijian on 16/1/25.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "AppDelegate.h"
#import "XMPPFramework.h"
/*
 在这里面实现登录
 1.初始化xmppstream
 2 连接到服务器 （发送一个JID）
 3 连接成功之后发生密码
 4 授权成功之后 发送在线消息

 */

@interface AppDelegate ()<XMPPStreamDelegate>{
    XMPPStream *xmppStream;
}
//1.初始化xmppstream
- (void)setupXMPPStream;

//2 连接到服务器 （发送一个JID）
- (void)connectToHost;

//3 连接成功之后发生密码
- (void)sendPwdToHost;

//4 授权成功之后 发送在线消息
- (void)senOnlineToHost;
@end

@implementation AppDelegate


#pragma mark - 私用方法
-(void)setupXMPPStream{
    xmppStream = [[XMPPStream alloc] init];

    //设置代理
    [xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [self connectToHost];

    return YES;
}

- (void)connectToHost{
    NSLog(@"开始连接服务器");
    if (!xmppStream) {
        [self setupXMPPStream];
    }

    XMPPJID *myJID = [XMPPJID jidWithUser:@"lisi" domain:@"liudemacbook-pro.local" resource:@"iphone"];
    xmppStream.myJID = myJID;

    xmppStream.hostName = @"liudemacbook-pro.local";


    NSError *error = nil;
    if (![xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        NSLog(@"%@",error);
    }
}

- (void)sendPwdToHost{
    NSLog(@"发送秘码");
    NSError *error = nil;
    [xmppStream authenticateWithPassword:@"123456" error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}

- (void)senOnlineToHost{
    NSLog(@"发送在线消息");
    XMPPPresence *persence = [XMPPPresence presence];
    [xmppStream sendElement:persence];
}
#pragma mark - XMPPStreamDelegate
#pragma mark 与主机连接失败
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"与主机连接成功");
    [self sendPwdToHost];
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    NSLog(@"连接失败:%@",error);
}

#pragma mark - 授权
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"授权成功");
    [self senOnlineToHost];
}
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"授权失败:%@",error);
}

- (void)logout{
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [xmppStream sendElement:offline];
    [xmppStream disconnect];
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
