//
//  WCChatViewController.m
//  WeChat
//
//  Created by Liu Zhijian on 16/2/3.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "WCChatViewController.h"
#import  "WCInputView.h"

@interface WCChatViewController ()
@property (strong, nonatomic) NSLayoutConstraint *inputConstraint;//底部约束

@end

@implementation WCChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self setupView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbFirmWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)kbFirmWillChange:(NSNotification *)noti{
//   窗口的高度
    CGFloat windowH = [UIScreen mainScreen].bounds.size.height;
//   键盘结束时的frame
    CGRect kbEndFrm = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    CGFloat keEndy = kbEndFrm.origin.y;

    self.inputConstraint.constant = windowH - keEndy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupView{

    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
//     代码设置布局 要设置下面属性为NO
    tableView.translatesAutoresizingMaskIntoConstraints = NO;


    WCInputView *inputView = [WCInputView inputView];
    [self.view addSubview:inputView];
    inputView.translatesAutoresizingMaskIntoConstraints = NO;

//    自动布局

//    水平方向

    NSDictionary *views = @{@"tableview":tableView,
                            @"inputview":inputView};
    NSArray *tableHCinstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableview]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:tableHCinstraint];

    NSArray *inputviewHCinstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[inputview]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:inputviewHCinstraint];

//    垂直方向
    NSArray *vConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableview]-0-[inputview(50)]-0-|" options:0 metrics:nil views:views];
    self.inputConstraint = [vConstraint lastObject];

    [self.view addConstraints:vConstraint];

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
