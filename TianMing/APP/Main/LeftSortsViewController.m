//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "OtherViewController.h"
#import "HistoryViewController.h"
#import "MineSetViewController.h"
#import "FinancialViewController.h"
@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIImageView * driverIMG;
@property (nonatomic,strong)UIImageView * telIMG;
@property (nonatomic,strong)UIImageView * headIMG;
@property (nonatomic,strong)UILabel * driverLab;
@property (nonatomic,strong)UILabel * telLab;
@property (nonatomic,copy)NSString * telStr;
@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self createData];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    //[self.view addSubview:imageview];
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    self.view.backgroundColor = WC;
    self.telStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"tel"];
    NSIndexSet * indexSet = [[NSIndexSet alloc]initWithIndex:0];
    [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationTop];
    //[self createUI];
    
    
}

- (void)refreshTel{

    self.driverLab.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"tel"];
    self.telLab.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"tel"];
    NSLog(@"%@",self.telLab);
}

#pragma mark - 销毁时调用,移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)createUI{

    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"nil"];
    [self.view addSubview:imageview];
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTel)
                                                 name:@"changeTel"
                                               object:nil];
    self.telStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"tel"];
    NSIndexSet * indexSet = [[NSIndexSet alloc]initWithIndex:0];
    [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationTop];
    
    //[self createUI];
    
}

- (void)createData{

    NSDictionary * dic = @{@"id":Tel};
    [[HttpRequest sharedClient]httpRequestPOST:Register parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //        NSString * str  ;
        if ([responseObject[@"success"] integerValue] ==1) {
            Toast(@"获取成功");
            //[self openCountdown];
            
            
            
        }
        //        [self registerPhone:str];
        NSLog(@"responseObject%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //Toast(@"获取失败");
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
    if (indexPath.row==0) {
    
        cell.imageView.image = [UIImage imageNamed:@"gr_dd"];
        cell.textLabel.text = @"历史订单";
    }
    else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"gr_xx"];
        cell.textLabel.text = @"我的消息";
    } else if (indexPath.row == 2) {
        
        cell.imageView.image = [UIImage imageNamed:@"gr_wm"];
        cell.textLabel.text = @"关于我们";
        
    } else if (indexPath.row == 3) {
        
        cell.imageView.image = [UIImage imageNamed:@"gr_lx"];
        cell.textLabel.text = @"联系我们";
    } else if (indexPath.row == 4) {
        //cell.imageView.image = [UIImage imageNamed:@"jrfw"];
        //cell.textLabel.text = @"金融服务";
        cell.imageView.image = [UIImage imageNamed:@"gr_sz"];
        cell.textLabel.text = @"设置";
    } else if (indexPath.row == 5) {
        cell.imageView.image = [UIImage imageNamed:@"set_an1"];
        cell.textLabel.text = @"设置";
        
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"紧急事件";
    } else if (indexPath.row == 7) {
        cell.textLabel.text = @"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if (indexPath.row==0) {
        HistoryViewController * hisVC = [[HistoryViewController alloc]init];
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainNavigationController pushViewController:hisVC animated:NO];
    } else if (indexPath.row==1) {
//        HistoryViewController * hisVC = [[HistoryViewController alloc]init];
//        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
//        [tempAppDelegate.mainNavigationController pushViewController:hisVC animated:NO];
    }else if (indexPath.row==2) {
        OtherViewController * otherVC = [[OtherViewController alloc]init];
        otherVC.titleStr = @"关于我们";
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainNavigationController pushViewController:otherVC animated:NO];
    }else if (indexPath.row==3) {
        OtherViewController * otherVC = [[OtherViewController alloc]init];
        otherVC.titleStr = @"联系我们";
        
    }else if (indexPath.row==4) {
        
//        FinancialViewController * vc = [[FinancialViewController alloc]init];
//        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
//        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
        MineSetViewController * VC = [[MineSetViewController alloc]init];
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainNavigationController pushViewController:VC animated:NO];
    }else{
    
        MineSetViewController * VC = [[MineSetViewController alloc]init];
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainNavigationController pushViewController:VC animated:NO];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (indexPath.row==0) {
//        return 120;
//    }
//    return 30;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    //view.backgroundColor = [UIColor clearColor];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_W-100)/2-30, 60, 60, 60)];
    self.headIMG = imgView;
    imgView.image = [UIImage imageNamed:@"sjd_tx"];
    [view addSubview:imgView];
    imgView.clipsToBounds =  YES;
    imgView.layer.cornerRadius = 30;
    self.driverIMG = [[UIImageView alloc]initWithFrame:CGRectMake(80, 100, 20, 20)];
    self.driverIMG.image = [UIImage imageNamed:@"ydlb_an4"];
    //[view addSubview:self.driverIMG];
    UILabel * driverLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_W-100)/2-100, 130, 200, 20)];
    driverLab.text = self.telStr;
    self.driverLab = driverLab;
    driverLab.textColor = [UIColor blackColor];
    driverLab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:driverLab];
    
    self.telIMG = [[UIImageView alloc]initWithFrame:CGRectMake(80, 140, 20, 20)];
    self.telIMG.image = [UIImage imageNamed:@"ydlb_an4"];
    //[view addSubview:self.telIMG];
    UILabel * telLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_W-100)/2-100, 150, 200, 20)];
    self.telLab = telLab;
    telLab.textAlignment = NSTextAlignmentCenter;
    telLab.textColor = [UIColor darkGrayColor];
    telLab.text = self.telStr;
    //[view addSubview:telLab];
    return view;
}
@end
