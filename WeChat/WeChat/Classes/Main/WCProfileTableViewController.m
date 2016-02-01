//
//  WCProfileTableViewController.m
//  WeChat
//
//  Created by Liu Zhijian on 16/2/1.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "WCProfileTableViewController.h"
#import "AppDelegate.h"
#import "XMPPvCardTemp.h"

@interface WCProfileTableViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headView;//头像



@property (weak, nonatomic) IBOutlet UILabel *nickName;//昵称
@property (weak, nonatomic) IBOutlet UILabel *weixinNumber;//微信号

@property (weak, nonatomic) IBOutlet UILabel *bumen;//部门
@property (weak, nonatomic) IBOutlet UILabel *zhiwei;//职位

@property (weak, nonatomic) IBOutlet UILabel *dianhau;//电话
@property (weak, nonatomic) IBOutlet UILabel *gongsi;

@property (weak, nonatomic) IBOutlet UILabel *email;

@end

@implementation WCProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadvCard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark 加载个人信息
- (void)loadvCard{
    AppDelegate *app = [UIApplication sharedApplication].delegate;

    XMPPvCardTemp *myVcard = app.vCard.myvCardTemp;

    if (myVcard.photo) {
        self.headView.image = [UIImage imageWithData:myVcard.photo];
    }

    self.nickName.text = myVcard.nickname;

    NSString *user = [WCUserInfo sharedWCUserInfo].user;
    self.weixinNumber = [NSString stringWithFormat:@"微信名:%@",user];
    self.gongsi.text = myVcard.orgName;
    if ([myVcard.orgUnits count] > 0) {
        self.bumen.text = myVcard.orgUnits[0];
    }

    self.zhiwei.text = myVcard.title;

    self.dianhau.text = myVcard.note;

    self.email.text = myVcard.mailer;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    NSUInteger tag =cell.tag;

    if (tag ==2 ) {//不执行操作
        return;
    }

    if (tag ==0) {//选择照片
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相" otherButtonTitles:@"相册", nil];

        [sheet showInView:self.view];
    }else{
        //跳到下一个页面
        //
    }

    
    // Configure the cell...
    

}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;

    if (buttonIndex == 0) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
//显示图片选择器
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark 图片选择器代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    WCLog(@"%@",info);

    UIImage *image = info[UIImagePickerControllerEditedImage];

    self.headView.image = image;

    [self dismissViewControllerAnimated:YES completion:nil];

}

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
