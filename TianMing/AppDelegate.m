//
//  AppDelegate.m
//  TianMing
//
//  Created by 李智帅 on 17/1/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "AppDelegate.h"
#import "MainPageViewController.h"
#import "LeftSortsViewController.h"
#import "RegisterViewController.h"
#import "UMessage.h"
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()<UNUserNotificationCenterDelegate>
@property (nonatomic,copy) NSString * gotopagestring;
@property(nonatomic,strong) RegisterViewController * registerVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
////    
//    [self.window makeKeyAndVisible];
//self.window.backgroundColor = [UIColor whiteColor];
////    
////    self.myTabbar = [[MyTabbarController alloc]init];
////    
////    self.window.rootViewController = self.myTabbar;
//    MainViewController * mainVC = [[MainViewController alloc]init];
//    UINavigationController * homeNav = [[UINavigationController alloc]initWithRootViewController:mainVC];
//    self.window.rootViewController = homeNav;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
    [self.window makeKeyAndVisible];
//    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"tel"]) {
//        RegisterViewController *mainVC = [[RegisterViewController alloc] init];
//        self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
//        self.window.rootViewController =self.mainNavigationController;
//    }else{}
    
        RegisterViewController *mainVC = [[RegisterViewController alloc] init];
        self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
        
        LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
        self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
        self.window.rootViewController =self.LeftSlideVC;
    
    
//    RegisterViewController *mainVC = [[RegisterViewController alloc] init];
//    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    
    
   
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor grayColor]];
    //百度地图的引入
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:BaiduAK  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }else{
        NSLog(@"百度地图验证成功");
    }
    [self setUMessageWith:launchOptions];
    return YES;
}

//友盟推送初始化
-(void)setUMessageWith:(NSDictionary *)launchOptions{
    //初始化方法,也可以使用(void)startWithAppkey:(NSString *)appKey launchOptions:(NSDictionary * )launchOptions httpsenable:(BOOL)value;这个方法，方便设置https请求。
    //Ios  司机 Appkey 5b15ead7f43e4869c7000086   App Master Secret  9b3cplq3sq1f2unhsaxle1yj8hof3ftp
    [UMessage startWithAppkey:@"5b19f393f29d986a73000010" launchOptions:launchOptions];
    
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。或者1.4.0的文档
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭友盟自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        NSLog(@"%@",userInfo);
        self.gotopagestring = [userInfo objectForKey:@"channel"];
        if(self.window.rootViewController)
        {
            [self gotopageviewcontrollerWithUserInfo:userInfo];
        }
        else
        {
            
        }
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        
    }else{
        //应用处于后台时的本地推送接受
    }
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    [self stringWithDeviceToken:deviceToken];
}

-(NSString *)stringWithDeviceToken:(NSData *)deviceToken
{
    NSString *deviceTokenString2 = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                     
                                     stringByReplacingOccurrencesOfString:@">" withString:@""]
                                    
                                    stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",deviceTokenString2);
    //储存deviceToken
    [[NSUserDefaults standardUserDefaults]setObject:deviceTokenString2 forKey:@"deviceToken"];
    return deviceTokenString2;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
}

//接受远程推送，跳转到指定界面
-(void)gotopageviewcontrollerWithUserInfo:(NSDictionary*)userInfo{
    
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userId"])) {//用户退出登录，则不做处理
//        return;
//    }
    UITabBarController* tabbar = (UITabBarController*)self.window.rootViewController;
    if(self.gotopagestring){
        
        
    }
//    {
//        if ([self.gotopagestring isEqualToString:@"ROLE_AUTH"]) {//新用户引导角色认证
//            self.gotopagestring = nil;
//            TCAuthenticationVCViewController *controller = [[TCAuthenticationVCViewController alloc]init];
//            controller.hidesBottomBarWhenPushed = YES;
//            [(UINavigationController*)[tabbar selectedViewController]  pushViewController:controller animated:YES];
//        }else if ([self.gotopagestring isEqualToString:@"AUTH_SUCCESS"]) {//审核通过--查看认证详细界面
//            self.gotopagestring = nil;
//            TCAuthenticationVCViewController *controller = [[TCAuthenticationVCViewController alloc]init];
//            controller.userApplyStatus=@"已认证";
//            controller.hidesBottomBarWhenPushed = YES;
//            [(UINavigationController*)[tabbar selectedViewController]  pushViewController:controller animated:YES];
//        }else if ([self.gotopagestring isEqualToString:@"AUTH_FAIL"]) {//审核未通过--查看认证详细界面
//            self.gotopagestring = nil;
//            TCAuthenticationVCViewController *controller = [[TCAuthenticationVCViewController alloc]init];
//            controller.hidesBottomBarWhenPushed = YES;
//            controller.userApplyStatus=@"未通过";
//            [(UINavigationController*)[tabbar selectedViewController]  pushViewController:controller animated:YES];
//        }else if ([self.gotopagestring isEqualToString:@"OFFER"]) {//承运方报价
//            self.gotopagestring = nil;
//            TCMyPublishDetailVC *controller = [[TCMyPublishDetailVC alloc]init];
//            controller.tenderId=userInfo[@"tenderId"];
//            controller.hidesBottomBarWhenPushed = YES;
//            [(UINavigationController*)[tabbar selectedViewController]  pushViewController:controller animated:YES];
//        }else if ([self.gotopagestring isEqualToString:@"UPDATE_OFFER"]) {//承运方修改报价--报价页面
//            self.gotopagestring = nil;
//            TCMyPublishDetailVC *controller = [[TCMyPublishDetailVC alloc]init];
//            controller.tenderId=userInfo[@"tenderId"];
//            controller.hidesBottomBarWhenPushed = YES;
//            [(UINavigationController*)[tabbar selectedViewController]  pushViewController:controller animated:YES];
//        }else if ([self.gotopagestring isEqualToString:@"MEAD_ORDER"]){//订单生成---订单详细界面
//            self.gotopagestring = nil;
//            TCOrderDetailViewController *controller = [[TCOrderDetailViewController alloc]init];
//            /**订单编号*/
//            controller.orderNum=userInfo[@"orderNum"];
//            /**订单Id*/
//            controller.orderId=userInfo[@"orderId"];
//            controller.hidesBottomBarWhenPushed = YES;
//            [(UINavigationController*)[tabbar selectedViewController]  pushViewController:controller animated:YES];
//        }else if ([self.gotopagestring isEqualToString:@"UPDATE_ORDER"]) {//订单状态发生变化---订单详细界面
//            self.gotopagestring = nil;
//            TCOrderDetailViewController *controller = [[TCOrderDetailViewController alloc]init];
//            /**订单编号*/
//            controller.orderNum=userInfo[@"orderNum"];
//            /**订单Id*/
//            controller.orderId=userInfo[@"orderId"];
//            controller.hidesBottomBarWhenPushed = YES;
//            [(UINavigationController*)[tabbar selectedViewController]  pushViewController:controller animated:YES];
//        }else if ([self.gotopagestring isEqualToString:@"UPDATE_WAYBILL"]) {//运单状态发生变化---运单列表界面
//            self.gotopagestring = nil;
//            TCTransportTableViewController *controller = [[TCTransportTableViewController alloc]init];
//            controller.hidesBottomBarWhenPushed = YES;
//            /**订单编号*/
//            controller.orderNum=userInfo[@"orderNum"];
//            /**订单Id*/
//            controller.orderId=userInfo[@"orderId"];
//            [(UINavigationController*)[tabbar selectedViewController]  pushViewController:controller animated:YES];
//        }
//        
//    }
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //[[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userId"];
    //    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"tel"];
    [[NSUserDefaults standardUserDefaults]setObject:@NO forKey:@"isUpdate"];
    //NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userSubType"]);
    
    
}


@end
