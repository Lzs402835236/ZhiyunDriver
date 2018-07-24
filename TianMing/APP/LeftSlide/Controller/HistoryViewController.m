//
//  HistoryViewController.m
//  TianMing
//
//  Created by 李智帅 on 17/1/20.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryTableViewCell.h"
#import "HistoryModel.h"
#import "HomeModel.h"
#import "DetailViewController.h"
@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int page;
    UITableView * _tableView;
    
}

@property(nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation HistoryViewController
#pragma mark - lazyLoad
- (NSMutableArray *)dataArr{

    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAINCOLOR;
    [self createUI];
    [self createNav];
    [self setupRefresh];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark - createUI
- (void)createUI{

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.backgroundColor =WC;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.backgroundColor = WC;
    _tableView.tableFooterView = view;
    [self.view addSubview: _tableView];
    //[self.view addSubview:_tableView];
}

#pragma mark - 初始化MJRefesh
- (void)setupRefresh
{
    // header
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    _tableView.header.autoChangeAlpha = YES;
    [_tableView.header beginRefreshing];
    // footer
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    _tableView.footer.hidden=YES;
}
#pragma mark - 加载数据
- (void)loadNew
{   page=1;
    //取消网络请求
    [[HttpRequest sharedClient] cancelRequest];

    NSMutableDictionary*dict=[NSMutableDictionary dictionary];
    
    [dict setObject:@(page) forKey:@"pageNumber"];
    [dict setObject:Tel forKey:@"driverTel"];
    [dict setObject:@"5" forKey:@"orderDetailStatus"];
    
    [dict setObject:@"10" forKey:@"pageSize"];
    //    [dict setObject:@(self.selectedIndex) forKey:@"orderDetailStatus"];
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kTransportDetail parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj){
        self.dataArr= (NSMutableArray*)[HomeModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        [_tableView.header endRefreshing];
        
        /** 如果是不是最后一页，则底部显示加载更多*/
        NSString*isLastPage=responseObject[@"data"][@"isLastPage"];
        
        if ([isLastPage integerValue]==0){ _tableView.footer.hidden=NO;}
        else{
            
            _tableView.footer.hidden=YES;
        }
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [_tableView.header endRefreshing];
    }];
}


#pragma mark - 加载更多数据
- (void)loadMore
{    page++;
   
    NSMutableDictionary*dict=[NSMutableDictionary dictionary];
//    [dict setObject:@(0) forKey:@"orderStatus"];
//    [dict setObject:@(page) forKey:@"pageNumber"];
//    [dict setObject:@"5" forKey:@"pageSize"];
//    [dict setObject:@"123456" forKey:@"userId"];
//    [dict setObject:@"OPEN" forKey:@"userType"];
    
    [dict setObject:@(page) forKey:@"pageNumber"];
    [dict setObject:Tel forKey:@"driverTel"];
    [dict setObject:@"5" forKey:@"orderDetailStatus"];
    
    [dict setObject:@"10" forKey:@"pageSize"];
    
    
    [[HttpRequest sharedClient]httpRequestPOST:kTransportDetail parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSMutableArray*arr=[NSMutableArray array];
        arr= (NSMutableArray*)[HomeModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        
        [self.dataArr addObjectsFromArray:arr];
        [_tableView.footer endRefreshing];
        
        /** 如果是不是最后一页，则底部显示加载更多*/
        NSString*isLastPage=responseObject[@"data"][@"isLastPage"];
        
        if ([isLastPage integerValue]==0){_tableView.footer.hidden=NO;}
        else{
            
            _tableView.footer.hidden=YES;
        }
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //ToastError(@"网络错误");
        [_tableView.footer endRefreshing];
    }];
    
}

#pragma mark - createNav
- (void)createNav{

    self.titleLabel.text = @"历史运单";
    self.titleLabel.textColor = [UIColor colorWithRed:46/255.0 green:46/255.0 blue:46/255.0 alpha:1];
    [self.leftButton setImage:[UIImage imageNamed:@"btn_left"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - backClick
- (void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //return 3;
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 115.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cell = @"HistoryCell";
    HistoryTableViewCell * hisCell =  [tableView dequeueReusableCellWithIdentifier:cell];
    if (!hisCell) {
        hisCell = [[HistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
    }
    
    if (self.dataArr.count) {
        
        HomeModel * model = self.dataArr[indexPath.row];;
        [hisCell refresh:model];

    }
    
    return hisCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    HomeModel * model = self.dataArr[indexPath.row];
    
    DetailViewController * detailVC = [[DetailViewController alloc]init];
    
    detailVC.orderDetailsNum = model.orderDetailsNum;
    
    [self.navigationController pushViewController:detailVC animated:YES];
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
