//
//  UIregisterViewController.m
//  WeChat
//
//  Created by Liu Zhijian on 16/1/30.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "UIregisterViewController.h"
#import "AppDelegate.h"

@interface UIregisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *registeBtn;

@end

@implementation UIregisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        self.leftConstraints.constant = 30;
        self.rightConstraints.constant =30;

        self.userField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
        self.passwordField.background = [UIImage stretchedImageWithName: @"operationbox_text"];

        [self.registeBtn setN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
    }

   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
- (IBAction)registerBtnclick:(id)sender {
//注册时候要把键盘隐藏掉
    [self.view endEditing:YES];

//    判断用户输入的是否为手机号
    if (![self.userField isTelphoneNum]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
//将注册数据写到单例中
    WCUserInfo *userInfo = [WCUserInfo sharedWCUserInfo];
    userInfo.registerUser = self.userField.text;
    userInfo.registerpwd = self.passwordField.text;

//调用appDelegate的登录方法
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.registerOperation = YES;
    [MBProgressHUD showMessage:@"正在注册中..." toView:self.view];

    __weak typeof(self) selfvc = self;
    [app xmppUserRegister:^(XMPPResultType type) {
        [selfvc handleResultType:type];
        

    }];

}

- (void)handleResultType:(XMPPResultType)type{
//    页面刷新必须是主线程中
    dispatch_async(dispatch_get_main_queue(), ^{
//        隐藏提示界面
        [MBProgressHUD hideHUDForView:self.view];
        switch (type) {
            case XMPPResultTyperegisterSuccess:
                [MBProgressHUD showError:@"注册成功" toView:self.view];
                //    登录后来到主页面
                [self dismissViewControllerAnimated:YES completion:nil];
                
                if ([self.delegate respondsToSelector:@selector(registerViewControllerDifinshRegister)]) {
                    [self.delegate  registerViewControllerDifinshRegister];
                }
                break;
            case XMPPResultTyperegisterFiald:
                [MBProgressHUD showError:@"注册失败,你的用户名已被使用" toView:self.view];
                break;
                default:
                break;
        }

    });
}

- (void)enterMainPage{
    //    更改用户的登录信息状态为 YES
//    [WCUserInfo sharedWCUserInfo].longinStatus = YES;

    //    保存数据到沙盒
//    [[WCUserInfo sharedWCUserInfo]saveUserInfoToSanBox];
    //    隐藏模态窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    //    登录成功来到主界面

    
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)textChanged:(id)sender {

    BOOL enabled = (self.userField.text.length != 0 && self.passwordField.text.length != 0);
    self.registeBtn.enabled = enabled;
    
}
- (IBAction)pwdChanged:(id)sender {
    BOOL enabled = (self.userField.text.length != 0 && self.passwordField.text.length != 0);
    self.registeBtn.enabled = enabled;

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
