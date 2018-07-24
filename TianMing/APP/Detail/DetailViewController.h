//
//  DetailViewController.h
//  TianMing
//
//  Created by 李智帅 on 17/1/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailViewController : BaseViewController
/*
 运单号
 **/
@property (nonatomic,strong)UIImageView * waybillIMG;//运单图
@property (nonatomic,strong)UILabel * waybillLabel;//运单号
@property (nonatomic,strong)UILabel * sendInfoLabel;//发货人信息
@property (nonatomic,strong)UIImageView * sendIMG;//发图
@property (nonatomic,strong)UILabel * sendNameLabel;//发货人姓名
@property (nonatomic,strong)UILabel * sendTelLabel;//发货人电话
@property (nonatomic,strong)UILabel * getAdressLabel;//装货地址
@property (nonatomic,strong)UIImageView * getIMG;//收图
@property (nonatomic,strong)UILabel * getInfoLabel;//收货人信息
@property (nonatomic,strong)UILabel * getNameLabel;//收货人姓名
@property (nonatomic,strong)UILabel * getTelLabel;//收货人电话
@property (nonatomic,strong)UILabel * sendAddressLab;//卸货地址
@property (nonatomic,strong)UIImageView * goodsIMG;//货图
@property (nonatomic,strong)UILabel * goodsInfoLab;//货物信息
@property (nonatomic,strong)UILabel * goodsCategoryLab;//货物类型
@property (nonatomic,strong)UILabel * heightLab;//重量
@property (nonatomic,strong)UILabel * volumeLab;//体积
@property (nonatomic,strong)UILabel * discripLab;//描述
@property (nonatomic,strong)UIButton * getGoodsBtn;//去装货按钮
@property (nonatomic,strong)UIView * firstView;//1到7条线
@property (nonatomic,strong)UIView * secondView;
@property (nonatomic,strong)UIView * thirdView;
@property (nonatomic,strong)UIView * forthView;
@property (nonatomic,strong)UIView * fifthView;
@property (nonatomic,strong)UIView * sixthView;
@property (nonatomic,strong)UIView * seventhView;
@property (nonatomic,copy) NSString * orderDetailsNum;
@property (nonatomic,copy) NSString * mainId;
@property (nonatomic,copy) NSString * transStatus;
@end
