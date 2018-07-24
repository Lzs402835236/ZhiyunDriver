//
//  HomeModel.h
//  TianMing
//
//  Created by 李智帅 on 17/2/20.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property (nonatomic,copy)NSString * orderDetailsNum;//运单号
@property (nonatomic,copy)NSString *outCity ;//装货地址（市） ,
@property (nonatomic,copy)NSString *outCounty ; //装货地址（区） ,
@property (nonatomic,copy)NSString *outProvince ;// 装货地址（省）
@property (nonatomic,copy)NSString *receiveCity;// 卸货地址（市） ,
@property (nonatomic,copy)NSString *receiveCounty; //(string, optional): 卸货地址（区） ,
@property (nonatomic,copy)NSString *receiveProvince;// (string, optional): 卸货地址（省） ,
@property (nonatomic,copy)NSString *driverName; //(string, optional): 司机姓名 ,
@property (nonatomic,copy)NSString *driverTel;
@property (nonatomic,copy)NSString *tenderComName;// (string, optional): 发货公司名称
@property (nonatomic,copy)NSString *tenderName;//发布人姓名
@property (nonatomic,copy)NSString *tenderTel;//发布人电话
@property (nonatomic,copy)NSString *receiveName;//收货人姓名
@property (nonatomic,copy)NSString *receiveTel;//收货人电话
@property (nonatomic,copy)NSString *goodsType;//货物类型
@property (nonatomic,copy)NSString *goodsSize;//货物体积
@property (nonatomic,copy)NSString *sizeUnit;//重量
@property (nonatomic,copy)NSString *remarks;//货物描述
@property (nonatomic,assign)double actualTotalprice;//实际总价
@property (nonatomic,copy)NSString * endDateStr;// (string, optional): 结束时间 ,
@property (nonatomic,copy)NSString * startDateStr;// (string, optional): 开始时间 ,
@property (nonatomic,copy)NSString *transStatus;
@property (nonatomic,copy)NSString *mainId;
@property (nonatomic,assign)int delFlag;
@property (nonatomic,copy)NSString *createDateStr;//运单生成时间
@property (nonatomic,copy)NSString * userId;
@property (nonatomic,copy)NSString * imageUrl;//判断查看凭证是否有图
@property (nonatomic,copy)NSString * imageHeadUrl;
@property (nonatomic,assign)double actualNum;//重量

@end
