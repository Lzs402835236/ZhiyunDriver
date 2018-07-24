//
//  HistoryTableViewCell.h
//  TianMing
//
//  Created by 李智帅 on 17/2/4.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryModel.h"
#import "HomeModel.h"
@interface HistoryTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * waybillIMG;
@property(nonatomic,strong)UILabel * waybillNum;
@property(nonatomic,strong)UIImageView * statusIMG;
@property(nonatomic,strong)UILabel * statusLab;
@property(nonatomic,strong)UIImageView * beginIMG;
@property(nonatomic,strong)UILabel * beginLab;
@property(nonatomic,strong)UIImageView * pathIMG;
@property(nonatomic,strong)UIImageView * endIMG;
@property(nonatomic,strong)UILabel * endLab;
@property(nonatomic,strong)UIImageView * moneyIMG;
@property(nonatomic,strong)UILabel * moneyLab;
@property(nonatomic,strong)UILabel * waybillAddress;
@property(nonatomic,strong)UIImageView * waybillTimeIMG;
@property(nonatomic,strong)UILabel * waybillTime;
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UIView * whiteView;

- (void)refresh:(HomeModel *)model;
@end
