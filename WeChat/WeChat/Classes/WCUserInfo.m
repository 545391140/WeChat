//
//  WCUserInfo.m
//  WeChat
//
//  Created by Liu Zhijian on 16/1/29.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "WCUserInfo.h"

@implementation WCUserInfo

#define UserKey @"user"
#define LoginStatusKey @"LoginStatus"
#define PwdKey @"pwd"

singleton_implementation(WCUserInfo)

- (void)saveUserInfoToSanBox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:UserKey];
    [defaults setBool:self.longinStatus forKey:LoginStatusKey];
    [defaults setObject:self.pwd forKey:PwdKey];
    [defaults synchronize];
}

- (void)loadUserInfoFromSanBox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:UserKey];
    self.longinStatus = [defaults boolForKey:LoginStatusKey];
    self.pwd = [defaults objectForKey:PwdKey];
}

@end

