//
//  HistoryTableViewCell.m
//  TianMing
//
//  Created by 李智帅 on 17/2/4.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = MAINCOLOR;
        [self createUI];
    }
    return self;
}

#pragma mark - lazyLoda
- (UIView *)whiteView{
    
    if (!_whiteView) {
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(5,5, SCREEN_W-10,105)];
        _whiteView.clipsToBounds = YES;
        _whiteView.layer.cornerRadius = 4;
        _whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_whiteView];
    }
    return _whiteView;
}
- (UIImageView *)waybillIMG{

    if (!_waybillIMG) {
        _waybillIMG = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
        //[self addSubview:_waybillIMG];
        [_whiteView addSubview:_waybillIMG];
    }
    return _waybillIMG;
}

- (UILabel *)waybillNum{

    if (!_waybillNum) {
        _waybillNum = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, SCREEN_W - 90, 20)];
        _waybillNum.font = Font(13);
        _waybillNum.textColor = [UIColor darkGrayColor];
        _waybillNum.textAlignment = NSTextAlignmentLeft;
        _waybillNum.adjustsFontSizeToFitWidth = YES;
        //[self.contentView addSubview:_waybillNum];
        [_whiteView addSubview:_waybillNum];
    }
    return _waybillNum  ;
}

- (UIImageView *)statusIMG{

    if (!_statusIMG) {
        _statusIMG = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-90, 5, 30, 20)];
        //[self addSubview:_statusIMG];
        //[_whiteView addSubview:_statusIMG];
    }
    return _statusIMG;
}
- (UILabel * )statusLab{

    if (!_statusLab) {
        
        _statusLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W-70, 5, 60, 20)];
        _statusLab.font = Font(15);
        _statusLab.textColor = [UIColor darkGrayColor];
        _statusLab.textAlignment = NSTextAlignmentRight;
        _statusLab.adjustsFontSizeToFitWidth = YES;
        //[self.contentView addSubview:_statusLab];
        [_whiteView addSubview:_statusLab];
    }
    return _statusLab;
}

- (UIImageView * )beginIMG{

    if (!_beginIMG) {
        _beginIMG = [[UIImageView alloc]initWithFrame:CGRectMake(5, 30, 20, 20)];
        //[self addSubview:_beginIMG];
        //[_whiteView addSubview:_beginIMG];
    }
    return _beginIMG;
}

- (UILabel *)beginLab{

    if (!_beginLab) {
        _beginLab = [FactoryUI createLabelWithFrame:CGRectMake(5, 30,SCREEN_W-40, 20) text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
        _beginLab.textAlignment = NSTextAlignmentLeft;
        //[self addSubview:_beginLab];
        [_whiteView addSubview:_beginLab];
    }
    return _beginLab;
}

- (UIImageView *)pathIMG{

    if (!_pathIMG) {
        _pathIMG = [[UIImageView alloc]initWithFrame:CGRectMake(95, 35, 30, 10)];
        //[self addSubview:_pathIMG];
        //[_whiteView addSubview:_pathIMG];
    }
    return _pathIMG;
}

- (UIImageView *)endIMG{

    if (!_endIMG) {
        _endIMG = [[UIImageView alloc]initWithFrame:CGRectMake(130, 30, 20, 20)];
        //[self addSubview:_endIMG];
        //[_whiteView addSubview:_endIMG];
    }
    return _endIMG;
}

- (UILabel *)endLab{

    if (!_endLab) {
        _endLab = [FactoryUI createLabelWithFrame:CGRectMake(150, 30, 60, 20) text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
        //[self addSubview:_endLab];
        //[_whiteView addSubview:_endLab];
    }
    return _endLab;
}

- (UIImageView *)waybillTimeIMG{

    if (!_waybillTimeIMG) {
        _waybillTimeIMG = [[UIImageView alloc]initWithFrame:CGRectMake(5, 55, 20, 20)];
        //[self addSubview:_waybillTimeIMG];
        //[_whiteView addSubview:_waybillTimeIMG];
    }
    return _waybillTimeIMG;
}

- (UILabel * )waybillTime{

    if (!_waybillTime) {
        _waybillTime = [FactoryUI createLabelWithFrame:CGRectMake(5 ,55, SCREEN_W - 40, 20) text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
        _waybillTime.textAlignment = NSTextAlignmentLeft;
        //[self addSubview:_waybillTime];
        [_whiteView addSubview:_waybillTime];
    }
    return _waybillTime;
}
- (UIView *)lineView{

    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0 ,76, SCREEN_W,1)];
        //[self addSubview:_lineView];
        //[_whiteView addSubview:_lineView];
    }
    return _lineView;
}
- (UIImageView *)moneyIMG{
    
    if (!_moneyIMG) {
        _moneyIMG = [[UIImageView alloc]initWithFrame:CGRectMake(5, 80, 20, 20)];
        //[self addSubview:_moneyIMG];
        //[_whiteView addSubview:_moneyIMG];
    }
    return _moneyIMG;
}

- (UILabel *)moneyLab{
    
    if (!_moneyLab) {
        _moneyLab = [FactoryUI createLabelWithFrame:CGRectMake(5, 80,SCREEN_W-40, 20) text:@"" textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15]];
        _moneyLab.textAlignment = NSTextAlignmentLeft;
        //[self addSubview:_moneyLab];
        [_whiteView addSubview:_moneyLab];
    }
    return _moneyLab;
}

//
//- (UILabel *)waybillTime{
//
//    if (!_waybillTime) {
//        _waybillTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, SCREEN_W, 20)];
//        _waybillTime.font =Font(13);
//        _waybillTime.textAlignment = NSTextAlignmentLeft;
//        _waybillTime.textColor = [UIColor blackColor];
//        _waybillTime.adjustsFontSizeToFitWidth = YES;
//        [self.contentView addSubview: _waybillTime];
//    }
//    return _waybillTime;
//}
//- (UILabel *)waybillAddress{
//
//    if (!_waybillAddress) {
//        _waybillAddress = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, SCREEN_W, 20)];
//        _waybillAddress.font =Font(13);
//        _waybillAddress.textAlignment = NSTextAlignmentLeft;
//        _waybillAddress.textColor = [UIColor blackColor];
//        _waybillAddress.adjustsFontSizeToFitWidth = YES;
//        [self.contentView addSubview: _waybillAddress];
//    }
//    return _waybillAddress;
//}

#pragma mark - createUI
- (void)createUI{

    self.waybillNum.text =[NSString stringWithFormat:@"运单号:%@",@"41564123131"];
    self.statusLab.text = @"已完成";
    self.waybillAddress.text = [NSString stringWithFormat:@"兰州->天津"];
    self.waybillTime.text = @"当前时间";
    
}

- (void)refresh:(HomeModel *)model{

    self.contentView.backgroundColor = MAINCOLOR;
    self.whiteView.backgroundColor = WC;
    self.waybillIMG.image = [UIImage imageNamed:@"ynh"];
    self.waybillNum.text =[NSString stringWithFormat:@"运单号:%@",model.orderDetailsNum];
    self.statusIMG.image = [UIImage imageNamed:@"lsyc_an6"];
    NSLog(@"%.2f",model.actualTotalprice);
    self.statusLab.text = model.transStatus;
    self.beginIMG.image = [UIImage imageNamed:@"fh_dd_xq_an2-1"];
    self.beginLab.text = [NSString stringWithFormat:@"%@-%@",model.outCity,model.receiveCity];
    self.pathIMG.image = [UIImage imageNamed:@"jt"];
    self.endIMG.image = [UIImage imageNamed:@"fh_dd_xq_an3-1"];
    self.endLab.text = [NSString stringWithFormat:@"%@",model.receiveCity];
    self.moneyIMG.image = [UIImage imageNamed:@"lsyc_an2"];
    self.moneyLab.text = [NSString stringWithFormat:@"运单生产时间:%@",model.createDateStr];
    
;
    self.waybillTimeIMG.image = [UIImage imageNamed:@"lsyc_an1"];
    self.waybillTime.text = [NSString stringWithFormat:@"运费:%.2f 元",model.actualTotalprice];
    self.lineView.backgroundColor = MAINCOLOR;
    
}

//#define SINGLE_LINE_HEIGHT  (1/[UIScreen mainScreen].scale)  // 线的高度
//#define  COLOR_LINE_GRAY [UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1]  //分割线颜色 #e0e0e0
//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
//    //下分割线
//    CGContextSetStrokeColorWithColor(context, COLOR_LINE_GRAY.CGColor); //  COLOR_LINE_GRAY 为线的颜色
//    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, SINGLE_LINE_HEIGHT)); //SINGLE_LINE_HEIGHT 为线的高度
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
