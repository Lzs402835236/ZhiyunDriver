//
//  AppDelegate.h
//  TianMing
//
//  Created by 李智帅 on 17/1/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property (strong, nonatomic) UINavigationController *mainNavigationController;

@end

