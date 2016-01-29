//
//  WCOtherLoginViewCOntroller.m
//  WeChat
//
//  Created by Liu Zhijian on 16/1/28.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "WCOtherLoginViewCOntroller.h"
#import "AppDelegate.h"

@interface WCOtherLoginViewCOntroller ()
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pawField;

@property (weak, nonatomic) IBOutlet UIButton *btnlogin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraints;
@end

@implementation WCOtherLoginViewCOntroller

- (void)viewDidLoad {
    [super viewDidLoad];

    //判断当前适配的类型 在设定约束
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        self.leftConstraints.constant = 30;
        self.rightConstraints.constant = 30;
    }

//    设置tixtFied的图片
    self.userField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    self.pawField.background = [UIImage stretchedImageWithName: @"operationbox_text"];

    [self.btnlogin setN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 登录
- (IBAction)loginBtnClick:(id)sender {
//     把用户名和密码放在沙盒里

//     调用APPDelegate的一个connect链接服务器

    NSString *uesr = self.userField.text;
    NSString *pwd = self.pawField.text;

    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setObject:uesr forKey:@"user"];
    [defults setObject:pwd forKey:@"pwd"];
    [defults synchronize];

//    隐藏键盘
    [self.view endEditing:YES];
//    登录前有个提示
    [MBProgressHUD showMessage:@"正在登录..." toView:self.view];
//    防止内存泄漏 将self变成弱引用
    __weak typeof(self) selfvc = self;
//    调用登录方法
    AppDelegate *app = [UIApplication sharedApplication].delegate;
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
//    隐藏模态窗口
    [self dismissViewControllerAnimated:YES completion:nil];
//    登录成功来到主界面
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
    self.view.window.rootViewController = storyboard.instantiateInitialViewController;
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc{
    WCLog(@"%s",__func__);
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
