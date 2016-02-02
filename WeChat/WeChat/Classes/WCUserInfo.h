//
//  WCUserInfo.h
//  WeChat
//
//  Created by Liu Zhijian on 16/1/29.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

static NSString * domain = @"liudemacbook-pro.local";


@interface WCUserInfo : NSObject

singleton_interface(WCUserInfo);//声明

@property (nonatomic, copy) NSString *user;//用户名
@property (nonatomic, copy) NSString *pwd;//密码

@property (nonatomic, assign) BOOL longinStatus;// 登录的状态

// YES 登录过
// NO 未登录

@property (nonatomic, copy) NSString *registerUser; // 注册名字
@property (nonatomic, copy) NSString *registerpwd;//注册的密码

@property (nonatomic, copy) NSString *jid;




//保持用户数据到沙盒里
- (void)saveUserInfoToSanBox;
//从沙盒中获取数据
- (void)loadUserInfoFromSanBox;

@end
