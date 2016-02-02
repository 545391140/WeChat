//
//  AppDelegate.h
//  WeChat
//
//  Created by Liu Zhijian on 16/1/28.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCNavigationController.h"
#import "XMPPFramework.h"

typedef enum{
    XMPPResultTypeloginSuccess,//登录成功
    XMPPResultTypeloginFailed,//登录失败
    XMPPResultTypeloginNetError,
    XMPPResultTyperegisterSuccess, //注册成功
    XMPPResultTyperegisterFiald
} XMPPResultType;

typedef void (^XMPPResultBlock)(XMPPResultType type);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign ,getter=isRegisterOperation) BOOL registerOperation;//注册标识符 yes 代表注册 
//用户登录
- (void)xmppUserlogin:(XMPPResultBlock)resultBlock;

//用户注销
- (void)logout;

//用户注册方法
- (void)xmppUserRegister:(XMPPResultBlock)resultBlock;

@property (strong, nonatomic) XMPPvCardTempModule *vCard;

//   花名册模块
@property (strong, nonatomic) XMPPRoster *roster;
@property (nonatomic,strong) XMPPRosterCoreDataStorage *rosterStronge;


@end

