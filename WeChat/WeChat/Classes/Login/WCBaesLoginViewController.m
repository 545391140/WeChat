//
//  WCBaesLoginViewController.m
//  WeChat
//
//  Created by Liu Zhijian on 16/1/30.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "WCBaesLoginViewController.h"
#import "AppDelegate.h"

@interface WCBaesLoginViewController ()

@end

@implementation WCBaesLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login {
    

    //    隐藏键盘
    [self.view endEditing:YES];
    //    登录前有个提示
    [MBProgressHUD showMessage:@"正在登录..." toView:self.view];
    //    防止内存泄漏 将self变成弱引用
    __weak typeof(self) selfvc = self;
    //    调用登录方法
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.registerOperation = NO;
    [app xmppUserlogin:^(XMPPResultType type) {
        [selfvc handleResultType:type];
    }];
}

- (void)handleResultType:(XMPPResultType)type{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view];
        switch (type) {
            case XMPPResultTypeloginSuccess:
                WCLog(@"登录成功");
                //    登录后来到主页面
                [self enterMainPage];

                break;

            case XMPPResultTypeloginFailed:
                WCLog(@"登录失败");
                [MBProgressHUD showError:@"用户名或者密码不正确" toView:self.view];
                break;
            case XMPPResultTypeloginNetError:
                [MBProgressHUD showError:@"网络不给力" toView:self.view];
            default:
                break;
        }

    });
}

- (void)enterMainPage{
    //    更改用户的登录信息状态为 YES
    [WCUserInfo sharedWCUserInfo].longinStatus = YES;

    //    保存数据到沙盒
    [[WCUserInfo sharedWCUserInfo]saveUserInfoToSanBox];
    //    隐藏模态窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    //    登录成功来到主界面
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//    self.view.window.rootViewController = storyboard.instantiateInitialViewController;
    [UIStoryboard showInitialVCWithName:@"main"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
