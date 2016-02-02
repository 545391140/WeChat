//
//  WCEditProfileTableViewController.h
//  WeChat
//
//  Created by Liu Zhijian on 16/2/1.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WCEditProfileTableViewControllerDelegate <NSObject>

- (void)WCEditProfileTableViewControllerDidsave;

@end

@interface WCEditProfileTableViewController : UITableViewController

@property (nonatomic,strong) UITableViewCell *cell;

@property (nonatomic, weak) id<WCEditProfileTableViewControllerDelegate> delegate;


@end
