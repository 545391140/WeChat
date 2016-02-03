//
//  WCNavigationController.m
//  WeChat
//
//  Created by Liu Zhijian on 16/1/29.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "WCNavigationController.h"

@interface WCNavigationController ()

@end

@implementation WCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)initialize{


}

//设置导航栏主题
+ (void)setupNaTheme{
    //    设置导航条的背景
    //    设置导航栏的字体
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7"] forBarMetrics:UIBarMetricsDefault];
//  设置字体的颜色
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [bar setTitleTextAttributes:att];
//设置状态栏的样式 默认的情况  状态栏的样式由控制器决定
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;


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
