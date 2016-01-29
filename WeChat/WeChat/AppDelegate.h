//
//  AppDelegate.h
//  WeChat
//
//  Created by Liu Zhijian on 16/1/28.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    XMPPResultTypeloginSuccess,//登录成功
    XMPPResultTypeloginFailed //登录失败
} XMPPResultType;

typedef void (^XMPPResultBlock)(XMPPResultType type);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//用户登录
- (void)xmppUserlogin:(XMPPResultBlock)resultBlock;


@end

