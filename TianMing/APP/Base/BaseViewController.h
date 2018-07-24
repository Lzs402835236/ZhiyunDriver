//
//  BaseViewController.h
//  TimeMemory
//
//  Created by 李智帅 on 16/9/5.
//  Copyright © 2016年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
//左按钮
@property(nonatomic, strong) UIButton * leftButton;
//标题
@property (nonatomic,strong) UILabel * titleLabel;
//右按钮
@property (nonatomic,strong) UIButton * rightButton;

//响应事件
- (void)addLeftTarget:(SEL)selector;
- (void)addRightTarget:(SEL)selector;
@end
