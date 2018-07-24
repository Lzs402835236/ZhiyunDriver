//
//  SendGoodsViewController.m
//  TianCheng
//
//  Created by 李智帅 on 17/1/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SendGoodsViewController.h"

@interface SendGoodsViewController ()

@end

@implementation SendGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor greenColor];
    [self createNav];
    // Do any additional setup after loading the view.
}
#pragma mark createNav
- (void)createNav{
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    
    
    
    UILabel * titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, 100, 30) text:@"发货" textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:20]];
    
    self.navigationItem.titleView = titleLabel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
