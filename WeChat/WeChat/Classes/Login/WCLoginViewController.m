//
//  WCLoginViewController.m
//  WeChat
//
//  Created by Liu Zhijian on 16/1/29.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "WCLoginViewController.h"
#import "WCNavigationController.h"
#import "UIregisterViewController.h"

@interface WCLoginViewController ()<WCRegisterViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userLable;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation WCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.

    self.password.background = [UIImage imageNamed:@"operationbox_text"];

    [self.password addLeftViewWithImage:@"Card_Lock"];

    [self.login setBackgroundImage:[UIImage imageNamed:@"fts_green_btn_HL"] forState:UIControlStateNormal];
//    设置登录名为上次登录的名字
//    从沙盒获取用户名
    NSString *user = [WCUserInfo sharedWCUserInfo].user;

    self.userLable.text = user;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {
    WCUserInfo *userInFo = [WCUserInfo sharedWCUserInfo];
    userInFo.user = self.userLable.text;
    userInFo.pwd = self.password.text;
    
    [super login];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showregister"]) {
         id destVc = segue.destinationViewController;
        if ([destVc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = destVc;

            UIregisterViewController *regiVc = nav.topViewController;
                        
            regiVc.delegate = self;
            
            
        }

    }
    


}
#pragma mark -- registerViewControllerDifinshRegister代理

- (void) registerViewControllerDifinshRegister{
    NSLog(@"完成注册");
    self.userLable.text = [WCUserInfo sharedWCUserInfo].registerUser;
    [MBProgressHUD showSuccess:@"完成注册，请重新登录" toView:self.view];
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
