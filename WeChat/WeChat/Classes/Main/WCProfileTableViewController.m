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
#import "WCEditProfileTableViewController.h"

@interface WCProfileTableViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,WCEditProfileTableViewControllerDelegate>
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
    self.title = @"个人信息";
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

        [self performSegueWithIdentifier:@"EditVcard" sender:cell];

    }

    
    // Configure the cell...
    

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id destVc = segue.destinationViewController;
    if ([destVc isKindOfClass:[WCEditProfileTableViewController class ]]) {
        WCEditProfileTableViewController *edivC = destVc;
        edivC.cell = sender;
        edivC.delegate = self;
    }
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
// 获取图片 设置图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
// 隐藏模态窗口
    self.headView.image = image;

    [self dismissViewControllerAnimated:YES completion:nil];
    [self WCEditProfileTableViewControllerDidsave];

}

#pragma mark - WCEditProfileTableViewControllerDelegate

- (void)WCEditProfileTableViewControllerDidsave{
    //更新数据到服务器
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    XMPPvCardTemp *tempVcard = app.vCard.myvCardTemp;
//更新头像
    tempVcard.photo = UIImagePNGRepresentation(self.headView.image);

    //获取电子名片信息

    tempVcard.nickname = self.nickName.text;
    tempVcard.orgName = self.gongsi.text;
    if ([self.bumen.text length] > 0) {
        tempVcard.orgUnits = @[self.bumen.text];
    }

    tempVcard.title = self.zhiwei.text;

    tempVcard.note = self.dianhau.text;
    tempVcard.mailer = self.email.text;
    
    [app.vCard updateMyvCardTemp:tempVcard];

}



@end
