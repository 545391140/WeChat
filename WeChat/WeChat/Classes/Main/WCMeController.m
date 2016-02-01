//
//  WCMeController.m
//  WeChat
//
//  Created by Liu Zhijian on 16/1/29.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "WCMeController.h"
#import "AppDelegate.h"
#import "XMPPvCardTemp.h"

@interface WCMeController ()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headView;
//昵称
@property (weak, nonatomic) IBOutlet UILabel *nickLable;
//微信号
@property (weak, nonatomic) IBOutlet UILabel *weixinNamber;

@end

@implementation WCMeController

- (void)viewDidLoad {
    [super viewDidLoad];

//    当前用户的个人信息
//    xmpp提供了一个方法 直接获取个人信息
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    XMPPvCardTemp *mycVard = app.vCard.myvCardTemp;

//    NSLog(@"打印%@",mycVard);
//   设置头像
    if (mycVard.photo) {
        self.headView.image = [UIImage imageWithData:mycVard.photo];
    }
//  设置昵称

        self.nickLable.text = mycVard.nickname;

//  设置微信号
    NSString *user = [WCUserInfo sharedWCUserInfo].user;


    self.weixinNamber.text = [NSString stringWithFormat:@"微信号:%@",user];

    WCLog(@"已经加载");

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 1;
//}
- (IBAction)logout:(id)sender {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app logout];

}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
