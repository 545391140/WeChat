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


    WCUserInfo *userInfo = [WCUserInfo sharedWCUserInfo];
    userInfo.user = self.userField.text;
    userInfo.pwd = self.pawField.text;
    [super login];


   
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
