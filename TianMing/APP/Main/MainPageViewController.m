//
//  MainPageViewController.m
//  LeftSlide
//
//  Created by huangzhenyu on 15/6/18.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "MainPageViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

#import "HomeModel.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#define vBackBarButtonItemName  @"backArrow.png"    //导航条返回默认图片名
@interface MainPageViewController ()<BMKMapViewDelegate>
{

    //地图
    BMKMapView* _mapView;
    BMKPointAnnotation * pointAnnotation;
}
//存储查询得到的路线点---传给大地图VC。
@property(nonatomic,strong)NSMutableArray*locationArray;
@property (nonatomic,strong)UILabel * waybillLabel;
@property (nonatomic,strong)UILabel * beigainLabel;
@property (nonatomic,strong)UILabel * endLabel;
@property (nonatomic,strong)UIButton * detailBtn;
@property (nonatomic,strong)UIImageView * waybillIMG;
@property (nonatomic,strong)UIImageView * beigainIMG;
@property (nonatomic,strong)UIImageView * endIMG;
//@property (nonatomic,strong)UIView * mapView;
@property (nonatomic,strong)UIView * firstView;
@property (nonatomic,strong)UIView * secondView;
@property (nonatomic,strong)UIView * thirdView;
@property (nonatomic,strong)UIView * forthView;
@property (nonatomic,strong)UIView * fifthView;
//无数据覆盖view
@property (nonatomic,strong)UIView * whiteView;
@property (nonatomic,strong)UIButton * refreshBtn;
@property (nonatomic,strong)UIButton * baiduBtn;
@property (nonatomic,strong)UIButton * zhongjiaoBtn;
@end

@implementation MainPageViewController

#pragma mark - lazyLoad

- (UIView *)whiteView{

    if (!_whiteView) {
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_W-20,90)];
        _whiteView.clipsToBounds = YES;
        _whiteView.layer.cornerRadius = 5;
        _whiteView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_whiteView];
    }
    return _whiteView;
}

- (UIButton *)refreshBtn{

    if (!_refreshBtn) {
        _refreshBtn = [FactoryUI createButtonWithFrame:CGRectMake(SCREEN_W/2-80, 65, 160, 35) title:@"没有数据请点击刷新" titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(createData)];
    }
    return _refreshBtn;
}

-(NSMutableArray*)locationArray{
    if (!_locationArray) {
        _locationArray=[NSMutableArray array];
    }
    return _locationArray;
}

- (UIView *)firstView{

    if (!_firstView) {
        _firstView = [[UIView alloc]initWithFrame:CGRectMake(5,30, SCREEN_W-10, 1)];
        [_whiteView addSubview:_firstView];
    }
    return _firstView;
}
- (UIImageView *)waybillIMG{

    if (!_waybillIMG) {
        _waybillIMG = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
        [_whiteView addSubview:_waybillIMG];
    }
    return _waybillIMG;
}

- (UILabel * )waybillLabel{

    if (!_waybillLabel) {
        _waybillLabel = [[UILabel alloc]initWithFrame:CGRectMake(30,3, SCREEN_W-20-_waybillIMG.frame.size.width, 25)];
        _waybillLabel.adjustsFontSizeToFitWidth = YES;
        _waybillLabel.textColor = [UIColor lightGrayColor];
        _waybillLabel.textAlignment = NSTextAlignmentLeft;
        //_waybillLabel.font = Font(13);
        [_whiteView addSubview:_waybillLabel];
    }
    return _waybillLabel;
}

- (UIButton *)detailBtn{
    
    if (!_detailBtn) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        _detailBtn.clipsToBounds = YES;
        _detailBtn.layer.cornerRadius = 6;
        _detailBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _detailBtn.layer.borderWidth = 1;
        [_detailBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _detailBtn.frame = CGRectMake(SCREEN_W-110, 5, 80, 20);
        [_detailBtn addTarget:self action:@selector(detailBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //_detailBtn.backgroundColor = WC;
        [_whiteView addSubview:_detailBtn];
    }
    return _detailBtn;
}

- (UIView *)secondView{

    if (!_secondView) {
        _secondView = [[UIView alloc]initWithFrame:CGRectMake(5,60, SCREEN_W, 1)];
        [_whiteView addSubview:_secondView];
    }
    return _secondView;

}

- (UIView *)thirdView{
    
    if (!_thirdView) {
        _thirdView = [[UIView alloc]initWithFrame:CGRectMake(0,70, SCREEN_W, 1)];
        //[self.view addSubview:_thirdView];
    }
    return _thirdView;
    
}

- (UIImageView *)beigainIMG{

    if (!_beigainIMG) {
        _beigainIMG = [[UIImageView alloc]initWithFrame:CGRectMake(5,35, 20, 20)];
        [_whiteView addSubview:_beigainIMG];
    }
    return _beigainIMG;
}
- (UILabel *)beigainLabel{

    if (!_beigainLabel) {
        _beigainLabel = [[UILabel alloc]initWithFrame:CGRectMake(30,33, SCREEN_W-20, 30)];
        _beigainLabel.adjustsFontSizeToFitWidth = YES;
        _beigainLabel.textColor = [UIColor blackColor];
        _beigainLabel.textAlignment = NSTextAlignmentLeft;
        //_beigainLabel.font = Font(13);
        [_whiteView addSubview:_beigainLabel];
    }
    return _beigainLabel;
}

- (UIView *)forthView{
    
    if (!_forthView) {
        _forthView = [[UIView alloc]initWithFrame:CGRectMake(0,105, SCREEN_W, 1)];
        //[self.view addSubview:_forthView];
    }
    return _forthView;
    
}

- (UIImageView *)endIMG{

    if (!_endIMG) {
        _endIMG = [[UIImageView alloc]initWithFrame:CGRectMake(5, 65, 20, 20)];
        [_whiteView addSubview:_endIMG];
    }
    return _endIMG;
}
- (UILabel *)endLabel{

    if (!_endLabel) {
        _endLabel = [[UILabel alloc]initWithFrame:CGRectMake(30,63, SCREEN_W-20, 30)];
        _endLabel.adjustsFontSizeToFitWidth=YES;
        _endLabel.textAlignment = NSTextAlignmentLeft;
        _endLabel.textColor = [UIColor blackColor];
        //_endLabel.font = Font(13);
        [_whiteView addSubview:_endLabel];
    }
    return _endLabel;
}

- (UIView *)fifthView{
    
    if (!_fifthView) {
        _fifthView = [[UIView alloc]initWithFrame:CGRectMake(0,135, SCREEN_W, 1)];
        //[self.view addSubview:_fifthView];
    }
    return _fifthView;
    
}

- (UIButton *)zhongjiaoBtn{

    if (!_zhongjiaoBtn) {
        _zhongjiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _zhongjiaoBtn.frame = CGRectMake(0, 150, SCREEN_W, 20);
        [_zhongjiaoBtn setBackgroundColor:[UIColor lightGrayColor]];
        [_zhongjiaoBtn addTarget:self action:@selector(zhongjiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //[self.view addSubview:_zhongjiaoBtn];
    }
    return _zhongjiaoBtn;
}

- (UIButton *)baiduBtn{
    
    if (!_baiduBtn) {
        _baiduBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _baiduBtn.frame = CGRectMake(SCREEN_W/2-80, SCREEN_H-80, 160, 50);
        [_baiduBtn setBackgroundColor:[UIColor colorWithRed:241/255.0 green:102/255.0 blue:35/255.0 alpha:1]];
        [_baiduBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_baiduBtn addTarget:self action:@selector(BtnClickWith:) forControlEvents:UIControlEventTouchUpInside];
        _baiduBtn.clipsToBounds = YES;
        _baiduBtn.layer.cornerRadius = 6;
        
        [_mapView addSubview:_baiduBtn];
    }
    return _baiduBtn;
}

- (BMKMapView *)mapView{

    if (!_mapView) {
        //地图图片
        _mapView=[[BMKMapView alloc]init];
        _mapView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
        [_mapView setZoomLevel:19];
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

#pragma mark - detailBtnClick
- (void)detailBtnClick{

    NSLog(@"点击了详情");
    DetailViewController * detailVC = [[DetailViewController alloc]init];
    
    detailVC.orderDetailsNum = self.orderDetailsNum;
    detailVC.transStatus =self.transStatus;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - 切换按钮点击事件
- (void)zhongjiaoBtnClick{

    //self.locationArray = [NSMutableArray arrayWithCapacity:0];
    //清除已划线轨迹
    [_mapView removeOverlays:_mapView.overlays];
    [self.baiduBtn setTitle:@"切换到百度地图" forState:UIControlStateNormal];
    //return;
    NSDictionary * dict = @{@"entityName":self.orderDetailsNum,@"tag":@"Z"};
    //NSLog(@"dict%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kTransportDetailMap parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj){
        NSLog(@"%@",responseObject);
        self.locationArray = responseObject[@"data"];
        if (self.locationArray) {
            //绘制轨迹点
            //NSLog(@"绘制轨迹点%@",self.locationArray);
            Toast(@"已切换到中交兴路");
            [self drawPoint];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //ToastError(@"网络错误");
        
        
    }];
}
#pragma mark - TranceMap相关参数
static NSString * entityName;
// 135436
static NSUInteger serviceID = 200516 ;
double latitudeOfEntity;
double longitudeOfEntity;
- (void)TranceMap{

    _mapView.mapType = BMKMapTypeStandard;
   
    entityName = self.orderDetailsNum;

    // 使用SDK的任何功能前，都需要先调用initInfo:方法设置基础信息。
    BTKServiceOption *sop = [[BTKServiceOption alloc] initWithAK:BaiduAK mcode:@"com.ZhiYun.Lzs" serviceID:serviceID keepAlive:false];
    [[BTKAction sharedInstance] initInfo:sop];

    //视图加载之后就请求实时位置
    [[BTKAction sharedInstance] changeGatherAndPackIntervals:10 packInterval:60 delegate:self];
    [[BTKAction sharedInstance] setCacheMaxSize:60 delegate:self];
    [self queryEntityList];

    
    //开始追踪，异步执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BTKStartServiceOption *op = [[BTKStartServiceOption alloc] initWithEntityName:entityName];
        [[BTKAction sharedInstance] startService:op delegate:self];
        [[BTKAction sharedInstance] startGather:self];
        
        
       
    });
}
//请求实时位置
- (void)queryEntityList {
    
    BTKQueryTrackProcessOption *option = [[BTKQueryTrackProcessOption alloc] init];
    option.denoise = FALSE;
    option.mapMatch = FALSE;
    option.radiusThreshold = 55;
    option.transportMode = BTK_TRACK_PROCESS_OPTION_TRANSPORT_MODE_DRIVING;
    BTKQueryTrackLatestPointRequest *request = [[BTKQueryTrackLatestPointRequest alloc] initWithEntityName:entityName processOption:option outputCootdType:BTK_COORDTYPE_BD09LL serviceID:serviceID tag:11];
    [[BTKTrackAction sharedInstance] queryTrackLatestPointWith:request delegate:self];
     
}

#pragma mark - Entity相关的回调方法
#pragma mark - API track - 回调
-(void)onQueryTrackLatestPoint:(NSData *)response {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil];
    //NSString *entityListResult = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    //NSLog(@"实时位置查询结果: %@", entityListResult);
    //NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[entityListResult dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"API track - 回调track latestpoint response: %@", dic);
    NSNumber *status = [dic objectForKey:@"status"];
    if (0 == [status longValue]) {
        //NSArray *entities = [dic objectForKey:@"entities"];
        //NSDictionary *entity = [entities objectAtIndex:0];
        NSDictionary *realtimePoint = [dic objectForKey:@"latest_point"];
        //NSArray *location = [realtimePoint objectForKey:@"location"];
        longitudeOfEntity = [realtimePoint[@"longitude"] doubleValue];
        latitudeOfEntity = [realtimePoint[@"latitude"] doubleValue];
        NSLog(@"API track - 回调%f%f",longitudeOfEntity,latitudeOfEntity);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_mapView removeOverlays:_mapView.overlays];
            [_mapView removeAnnotations:_mapView.annotations];
        });
        [self addPointAnnotation];
    }

    
}
//-(void)onQueryEntity:(NSData *)response {
//    NSString *entityListResult = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//    NSLog(@"实时位置查询结果: %@", entityListResult);
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[entityListResult dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
//    NSNumber *status = [dic objectForKey:@"status"];
//    if (0 == [status longValue]) {
//        NSArray *entities = [dic objectForKey:@"entities"];
//        NSDictionary *entity = [entities objectAtIndex:0];
//        NSDictionary *realtimePoint = [entity objectForKey:@"realtime_point"];
//        NSArray *location = [realtimePoint objectForKey:@"location"];
//        longitudeOfEntity = [[location objectAtIndex:0] doubleValue];
//        latitudeOfEntity = [[location objectAtIndex:1] doubleValue];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_mapView removeOverlays:_mapView.overlays];
//            [_mapView removeAnnotations:_mapView.annotations];
//        });
//        [self addPointAnnotation];
//    }
//}
//- (void)onGetHistoryTrack:(NSData * _Nonnull)data{
//
//    
//}

//添加当前位置的标注
-(void)addPointAnnotation {
    
    CLLocationCoordinate2D coord;
    coord.latitude = latitudeOfEntity;
    coord.longitude = longitudeOfEntity;
    NSLog(@"当前位置%f%f",coord.latitude,coord.longitude);
    if (nil == pointAnnotation) {
        pointAnnotation = [[BMKPointAnnotation alloc] init];
    }
    pointAnnotation.coordinate = coord;
    
    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
    pt=(CLLocationCoordinate2D){latitudeOfEntity,longitudeOfEntity};
    pointAnnotation.title = @"最新位置";
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView setCenterCoordinate:coord animated:true];
        [_mapView addAnnotation:pointAnnotation];
    });
    
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if (annotation == pointAnnotation) {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            
            // 设置颜色
            annotationView.pinColor = BMKPinAnnotationColorGreen;
            // 从天上掉下效果
            annotationView.animatesDrop = YES;
            // 设置可拖拽
            annotationView.draggable = NO;
            //annotationView.annotation = annotation;
           // annotationView.image = [UIImage imageNamed:@"icon_center_point"];
        }
        return annotationView;
    }
    return nil;
}

#pragma mark - baiduBtnClick
- (void)baiduBtnClick{

    //self.locationArray = [NSMutableArray arrayWithCapacity:0];
    //清除已划线轨迹
    [_mapView removeOverlays:_mapView.overlays];
    [self.baiduBtn setTitle:@"切换到中交兴路" forState:UIControlStateNormal];
    //return;
    if ([self.transStatus isEqualToString:@"运输中"]) {
        Toast(@"已切换到百度地图");
        [self TranceMap];
        NSDictionary * dict = @{@"entityName":self.orderDetailsNum,@"tag":@"Y"};
        NSLog(@"dict%@",dict);
        [[HttpRequest sharedClient]httpRequestPOST:kTransportDetailMap parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj){
            NSLog(@"%@",responseObject);
            self.locationArray = responseObject[@"data"];
            if (self.locationArray) {
                //绘制轨迹点
                //NSLog(@"绘制轨迹点%@",self.locationArray);
                //Toast(@"已切换到百度地图");
                [self drawPoint];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            //ToastError(@"网络错误");
            
            
        }];
    }else{
        
        Toast(@"已切换到百度地图");
        NSDictionary * dict = @{@"entityName":self.orderDetailsNum,@"tag":@"Y"};
        //NSLog(@"dict%@",dict);
            [[HttpRequest sharedClient]httpRequestPOST:kTransportDetailMap parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj){
                //NSLog(@"%@",responseObject);
                self.locationArray = responseObject[@"data"];
                if (self.locationArray) {
                    //绘制轨迹点
                    //NSLog(@"绘制轨迹点%@",self.locationArray);
                    Toast(@"已切换到百度地图");
                    [self drawPoint];
                }
        
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                //ToastError(@"网络错误");
                
                
            }];
    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    [self createNav];
    [self createUI];
    [self createData];
    //[self createMapData];
    //[self login];
    
}

#pragma mark  - createUI
- (void)createUI
{
    self.mapView.backgroundColor = [UIColor whiteColor];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    self.firstView.backgroundColor = MAINCOLOR;
    self.waybillIMG.image = [UIImage imageNamed:@"ynh"];
    //self.waybillLabel.text = [NSString stringWithFormat:@"运单号: %@",@"花花"];
    self.secondView.backgroundColor = MAINCOLOR;
    //[self.detailBtn setBackgroundImage:[UIImage imageNamed:@"app_home_nav20"] forState:UIControlStateNormal];
    [self.detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    self.thirdView.backgroundColor = MAINCOLOR;
    self.beigainIMG.image = [UIImage imageNamed:@"fh_dd_xq_an2-1"];
    //self.beigainLabel.text = [NSString stringWithFormat:@"起点: %@",@"太平洋北岸"];
    self.forthView.backgroundColor = MAINCOLOR;
    self.endIMG.image = [UIImage imageNamed:@"fh_dd_xq_an3-1"];
    //self.endLabel.text = [NSString stringWithFormat:@"终点: %@",@"太平洋南岸"];
    self.fifthView.backgroundColor = MAINCOLOR;

//    [self.zhongjiaoBtn setTitle:@"切换到中交兴路轨迹" forState:UIControlStateNormal];
//    [self.zhongjiaoBtn setTitleColor:WC forState:UIControlStateNormal];
    [self.baiduBtn setTitle:@"切换到百度地图" forState:UIControlStateNormal];
    [self.baiduBtn setTitleColor:WC forState:UIControlStateNormal];

}
- (void)BtnClickWith:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self baiduBtnClick];
    }else{
        [self zhongjiaoBtnClick];
    }
}
#pragma mark - createNav
- (void)createNav{

    //self.title = @"安全出行";
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    self.titleLabel.text = @"运单详情";
    self.titleLabel.textColor = [UIColor colorWithRed:46/255.0 green:46/255.0 blue:46/255.0 alpha:1];
    //self.view.backgroundColor = [UIColor lightGrayColor];
    
//    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    menuBtn.frame = CGRectMake(0, 0, 20, 18);
//    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
//    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    [self.leftButton setImage:[UIImage imageNamed:@"sy_07"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
}

- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //self.view.window.rootViewController = tempAppDelegate.LeftSlideVC;
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    //[[BTRACEAction shared] stopTrace:self trace:traceInstance];
    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}
- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"isUpdate"]boolValue]){
        
        [self hsUpdateApp];
    }
}

- (void)createData{
    
    NSDictionary * dic = @{@"driverTel":Tel,@"orderDetailStatus":@"7",@"pageNumber":@1,@"pageSize":@1};
    //NSLog(@"%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:HomeUrl parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //NSLog(@"%@",responseObject);
        HomeModel*model1=[[HomeModel alloc]init];
        NSArray*arr=responseObject[@"data"][@"list"];
        if (arr.count!=0) {
            model1=[HomeModel objectWithKeyValues:responseObject[@"data"][@"list"][0]];
            [self createModel:model1];
        }else{
        
            Toast(@"没有数据");
            [self createUINone];
        }
        //NSLog(@"responseObject%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}
//没有数据
- (void)createUINone{

    
    self.whiteView.backgroundColor = MAINCOLOR;
    [self.whiteView addSubview:self.refreshBtn];
}

- (void)createMapData{
    
    NSDictionary * dict = @{@"entityName":self.orderDetailsNum};
    //NSLog(@"dict%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kTransportDetailMap parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj){
        //NSLog(@"%@",responseObject);
        self.locationArray = responseObject[@"data"];
        if (self.locationArray) {
            //绘制轨迹点
            //NSLog(@"绘制轨迹点%@",self.locationArray);
            [self drawPoint];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //ToastError(@"网络错误");
        
        
    }];
    
    
}
#pragma  mark - 绘制路线
- (void)drawPoint{
    
    CLLocationCoordinate2D*coors=malloc([self.locationArray count]*sizeof(CLLocationCoordinate2D));
    for (int i=0; i<self.locationArray.count; i++) {
        NSDictionary*dict=self.locationArray[i];
        coors[i].latitude=[dict[@"y"] floatValue];
        coors[i].longitude=[dict[@"x"] floatValue];
        
        if (i==0) {
            //将地图的中心设置为起点
            BMKMapStatus*status=[[BMKMapStatus alloc]init];
            status.targetGeoPt=coors[0];
            [_mapView setMapStatus:status];
        }
    }
    BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:coors count:self.locationArray.count];
    [_mapView addOverlay:polyline];
    
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay] ;
        polylineView.strokeColor = [UIColor redColor] ;
        polylineView.lineWidth = 1.5;
        
        return polylineView;
    }
    return nil;
}
#pragma mark - createModel
- (void)createModel:(HomeModel *)model{

    self.firstView.backgroundColor = MAINCOLOR;
    self.waybillIMG.image = [UIImage imageNamed:@"ynh"];
    self.waybillLabel.text = [NSString stringWithFormat:@"运单号: %@",model.orderDetailsNum];
    self.orderDetailsNum = model.orderDetailsNum;
    //self.secondView.backgroundColor = MAINCOLOR;
    //[self.detailBtn setBackgroundImage:[UIImage imageNamed:@"app_home_nav20"] forState:UIControlStateNormal];
    //self.thirdView.backgroundColor = MAINCOLOR;
    self.beigainIMG.image = [UIImage imageNamed:@"fh_dd_xq_an2-1"];
    self.beigainLabel.text = [NSString stringWithFormat:@"起点: %@%@%@",model.outProvince,model.outCity,model.outCounty];
    //self.forthView.backgroundColor = MAINCOLOR;
    self.endIMG.image = [UIImage imageNamed:@"fh_dd_xq_an3-1"];
    self.endLabel.text = [NSString stringWithFormat:@"终点: %@%@%@",model.receiveProvince,model.receiveCity,model.receiveCounty];
    //self.fifthView.backgroundColor = MAINCOLOR;
    
    self.mapView.backgroundColor = [UIColor whiteColor];
    //NSLog(@"transStatus%@",model.transStatus);
    self.transStatus = model.transStatus;
    [[NSUserDefaults standardUserDefaults]setObject:model.userId forKey:@"userId"];
    if ([self.transStatus isEqualToString:@"待确认"]) {
        
        [self zhongjiaoBtnClick];
        
    }else if ([self.transStatus isEqualToString:@"待运输"]){
    
        [self zhongjiaoBtnClick];
        
    }else if ([self.transStatus isEqualToString:@"已完成"]){
        
        [self zhongjiaoBtnClick];
        
    }else if ([self.transStatus isEqualToString:@"运输中"]){
        
        [self zhongjiaoBtnClick];
    }
    
}

#pragma mark - 自动更新检测
/**
 * 检测app更新
 */
-(void)hsUpdateApp
{
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    //NSLog(@"%@",infoDic);
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    
    //3从网络获取appStore版本号
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
    if (response == nil) {
        //NSLog(@"你没有连接网络哦");
        //Toast(@"你没有连接网络哦");
        return;
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        //NSLog(@"hsUpdateAppError:%@",error);
        return;
    }
    //    NSLog(@"%@",appInfoDic);
    NSArray *array = appInfoDic[@"results"];
    
    if (array.count < 1) {
        NSLog(@"此APPID为未上架的APP或者查询不到");
        return;
    }
    
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    //打印版本号
    //NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
    //设置版本号
    currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (currentVersion.length==2) {
        currentVersion  = [currentVersion stringByAppendingString:@"0"];
    }else if (currentVersion.length==1){
        currentVersion  = [currentVersion stringByAppendingString:@"00"];
    }
    appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (appStoreVersion.length==2) {
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
    }else if (appStoreVersion.length==1){
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
    }
    
    //4当前版本号小于商店版本号,就更新
    if([currentVersion floatValue] < [appStoreVersion floatValue])
    {
        UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",dic[@"version"]] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //此处加入应用在app store的地址，方便用户去更新，一种实现方式如下
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
            [[UIApplication sharedApplication] openURL:url];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isUpdate"];
        }];
        [alercConteoller addAction:actionYes];
        [alercConteoller addAction:actionNo];
        [self presentViewController:alercConteoller animated:YES completion:nil];
    }else{
        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
    }
    
}

@end
