//
//  WCInputView.m
//  WeChat
//
//  Created by Liu Zhijian on 16/2/3.
//  Copyright © 2016年 Liu Zhijian. All rights reserved.
//

#import "WCInputView.h"

@implementation WCInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (instancetype)inputView{
    return [[[NSBundle mainBundle] loadNibNamed:@"InputView" owner:nil options:nil]lastObject];
}
@end
