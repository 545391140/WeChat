//
//  UIregisterViewController.h
//  WeChat
//
//  Created by Liu Zhijian on 16/1/30.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WCRegisterViewControllerDelegate <NSObject>

- (void) registerViewControllerDifinshRegister;

@end

@interface UIregisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraints;

@property (nonatomic ,weak) id <WCRegisterViewControllerDelegate>delegate;

@end
