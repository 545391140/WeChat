//
//  WCContatiesTableViewController.m
//  WeChat
//
//  Created by Liu Zhijian on 16/2/2.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "WCContatiesTableViewController.h"
#import "XMPPRosterCoreDataStorage.h"

@interface WCContatiesTableViewController()<NSFetchedResultsControllerDelegate>{
    NSFetchedResultsController *_resultsCl;
}
@property (strong, nonatomic) NSArray *friends;

@end

@implementation WCContatiesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadFriends];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadFriends{
//   使用coredata 获取数据
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *conatext =  app.rosterStronge.mainThreadManagedObjectContext;
//    获取上下文
//    fetchrequenst 请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];

//    设置过滤
//    过滤当前登录用户的好友
    NSString *jid = [WCUserInfo sharedWCUserInfo].jid ;
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@",jid];
    request.predicate = pre;

//    排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors = @[sort];

//  执行请求
//    self.friends = [conatext executeFetchRequest:request error:nil];
//    NSLog(@"朋友%@",self.friends);

//    执行数据请求获取数据
    _resultsCl = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:conatext sectionNameKeyPath:nil cacheName:nil];
    _resultsCl.delegate = self;
    NSString *errror = nil;
    [_resultsCl performFetch:&errror];
    if (errror) {
        WCLog(@"%@",errror);
    }

}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _resultsCl.fetchedObjects.count;

   }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Cell = @"contactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];

    //    获取对应的好友
    XMPPUserCoreDataStorageObject *fried = _resultsCl.fetchedObjects[indexPath.row];

    switch ([fried.sectionNum intValue]) {
        case 0:
            cell.detailTextLabel.text = @"在线";
            break;
        case 1:
            cell.detailTextLabel.text = @"离开";
            break;
        case 2:
            cell.detailTextLabel.text = @"离线";
        default:
            break;
    }
    cell.textLabel.text = fried.jidStr;

    // Configure the cell...
    
    return cell;
}

#pragma mark -- 数据发生改变的时候调用
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    NSLog(@"数据给变");
    [self.tableView reloadData];
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
