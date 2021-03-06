//
//  AppDelegate.m
//  Xmpp
//
//  Created by Liu Zhijian on 16/1/25.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "AppDelegate.h"
#import "XMPPFramework.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
/*
 在这里面实现登录
 1.初始化xmppstream
 2 连接到服务器 （发送一个JID）
 3 连接成功之后发生密码
 4 授权成功之后 发送在线消息

 */

@interface AppDelegate ()<XMPPStreamDelegate>{
    XMPPStream *xmppStream;
    XMPPResultBlock _resultBlock;
//电子名片
   
    XMPPvCardCoreDataStorage *_vCardStorage;
//头像模块
    XMPPvCardAvatarModule *_avatar;
//自动连接模块
    XMPPReconnect *_reconnect;

   // XMPPRoster *_roster;

//   花名册模块
//    XMPPRoster *_roster;
//    XMPPRosterCoreDataStorage *_rosterStronge;

    XMPPMessageArchiving *_msgarchiving;
    XMPPMessageArchivingCoreDataStorage *_msgStrage;
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



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [DDLog addLogger:[DDTTYLogger sharedInstance]];

//    打印沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",path);



//  添加导航栏
    [WCNavigationController setupNaTheme];
//    从沙盒里加载数据到单例
    [[WCUserInfo sharedWCUserInfo] loadUserInfoFromSanBox];
//    判断用户的登录状态
    if ([WCUserInfo sharedWCUserInfo].longinStatus) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
        self.window.rootViewController = storyboard.instantiateInitialViewController;

        [self xmppUserlogin:nil];
    }
    return YES;
}

#pragma mark - 私用方法
-(void)setupXMPPStream{

   
    xmppStream = [[XMPPStream alloc] init];
//    添加聊天模块
    _msgStrage = [[XMPPMessageArchivingCoreDataStorage alloc] init];
    _msgarchiving = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:_msgStrage];
    [_msgarchiving activate:xmppStream];

    
//    添加花名册 获取好友列表
    self.rosterStronge = [[XMPPRosterCoreDataStorage alloc] init];
    _roster= [[XMPPRoster alloc] initWithRosterStorage:self.rosterStronge];
    [_roster activate:xmppStream];

//   自动连接模块
    _reconnect = [[XMPPReconnect alloc] init];
    [_reconnect activate:xmppStream];//激活
//    添加电子名片模块
    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    _vCard = [[XMPPvCardTempModule alloc] initWithvCardStorage:_vCardStorage];
//    激活电子名片
    [_vCard activate:xmppStream];

//    添加头像模块
    _avatar = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_vCard];

//    激活头像模块
    [_avatar activate:xmppStream];

    XMPPvCardTempModule* tempp = _vCard.myvCardTemp;
//    NSLog(@"temp %@",tempp);


    //设置代理
    [xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
}

- (void)connectToHost{
    NSLog(@"开始连接服务器");
    if (!xmppStream) {
        [self setupXMPPStream];
    }
//从沙盒里获取用户名
    NSString *user = nil;
    if (self.isRegisterOperation) {
        user = [WCUserInfo sharedWCUserInfo].registerUser;
    }else{
        user = [WCUserInfo sharedWCUserInfo].user;
    }


    XMPPJID *myJID = [XMPPJID jidWithUser:user domain:@"liudemacbook-pro.local" resource:@"iphone"];
    xmppStream.myJID = myJID;
//    xmppStream.hostPort = 1233;

    xmppStream.hostName = @"liudemacbook-pro.local";


    NSError *error = nil;
    if (![xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        NSLog(@"%@",error);
    }
}

- (void)sendPwdToHost{
    NSLog(@"发送秘码");
    NSError *error = nil;
    NSString *pwd = [WCUserInfo sharedWCUserInfo].pwd;
    [xmppStream authenticateWithPassword:pwd error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}

- (void)senOnlineToHost{

    NSLog(@"发送在线消息");

    XMPPPresence *persence = [XMPPPresence presence];
    [xmppStream sendElement:persence];
}
#pragma mark -- 销毁xmpp的相关资源
- (void)teardownXmpp{
//  移除代理
    [xmppStream removeDelegate:self];
//  停止模块

    [_reconnect deactivate];
    [_vCard deactivate];
    [_avatar deactivate];
    [_roster deactivate];
    [_msgarchiving deactivate];
//    断开连接
    [xmppStream disconnect];
//    清空资源
    _reconnect = nil;
    _vCard = nil;
    _vCardStorage = nil;
    _avatar = nil;
    _roster = nil;
    _rosterStronge = nil;
    _msgarchiving = nil;
    _msgStrage = nil;
    xmppStream = nil;
}

#pragma mark - XMPPStreamDelegate
#pragma mark 与主机连成功
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"与主机连接成功");
    if (self.isRegisterOperation) {
        //获得注册的密码
        NSString *pwd = [WCUserInfo sharedWCUserInfo].registerpwd;
        [xmppStream registerWithPassword:pwd error:nil];//发送注册的密码
    }else{
        [self sendPwdToHost];
    }
}

#pragma  mark -- 与主机连接失败
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
//  如果有错误，表示存在问题
//  如果没有错误，表示正常的断开连接（人为的断开连接）
    if (error && _resultBlock) {
        _resultBlock(XMPPResultTypeloginNetError);
    }

    NSLog(@"连接失败:%@",error);
}

#pragma mark - 授权
#pragma mark -- 登录成功
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"授权成功");
    [self senOnlineToHost];
//   回调登录成功
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeloginSuccess);
    }


}

#pragma  mark -- 登录失败
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"授权失败:%@",error);
//    判断block有无值 在回调给控制器
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeloginFailed);
    }
}

#pragma mark -- 注册成功
-(void)xmppStreamDidRegister:(XMPPStream *)sender{
    WCLog(@"注册成功");
    if (_resultBlock) {
        _resultBlock(XMPPResultTyperegisterSuccess);

    }
}

#pragma mark -- 注册失败
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    WCLog(@"注册失败:%@",error);
    if (_resultBlock) {
        _resultBlock(XMPPResultTyperegisterFiald);
    }
}

#pragma  mark -- 公有方法
#pragma  mark -- 注销
- (void)logout{
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [xmppStream sendElement:offline];
    [xmppStream disconnect];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"login" bundle:nil];
    self.window.rootViewController = storyboard.instantiateInitialViewController;

    [WCUserInfo sharedWCUserInfo].longinStatus = NO;
    [[WCUserInfo sharedWCUserInfo] saveUserInfoToSanBox];
}

#pragma mark -- 登录
- (void)xmppUserlogin:(XMPPResultBlock)resultBlock{

    _resultBlock = resultBlock;

//    断开之前的连接 解决上一个登录连接未释放的问题
    [xmppStream disconnect];

    [self connectToHost];
    

}
#pragma mark -- 注册方法
- (void)xmppUserRegister:(XMPPResultBlock)resultBlock{
    _resultBlock = resultBlock;

    [xmppStream disconnect];

    [self connectToHost];
}

- (void)dealloc{
    [self teardownXmpp];
}


@end
