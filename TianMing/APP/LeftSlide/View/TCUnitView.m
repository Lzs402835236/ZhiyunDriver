//
//  TCUnitView.m
//  TCDelivery
//
//  Created by 融合互联-------lisen on 17/2/7.
//
//

#import "TCUnitView.h"

@implementation TCUnitView
{
    NSArray*_rightImageArr;
    NSArray*_leftImageArr;
    NSDictionary*_imageDictionary;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.unitImageView=[[UIImageView alloc]init];
        self.unitImageView .contentMode=UIViewContentModeScaleAspectFit;
        [self.unitImageView setImage:[UIImage imageNamed:@"icon"] ];
        
        [self addSubview:self.unitImageView];
        
        self.unitTextLabel=[[UILabel alloc]init];
        self.unitTextLabel.font=Font(12);
        
        
        self.unitTextLabel.adjustsFontSizeToFitWidth=YES;
        
        [self addSubview:self.unitTextLabel];
        
        
        //吨 米 辆
    _rightImageArr=@[@"fh_dd_xq_an1",@"app_home_nav17",@"fh_dd_xq_an12",@"",@"",@"",@"",@"",@""];
        
        //起(10) 终 车 发布(13) 号 重 司机 发货时间(17）发 收 电话(20) 总 卸(22) 装 订单创建时间(24)
        
  _leftImageArr=@[@"fh_dd_xq_an2",@"fh_dd_xq_an2-1",@"app_home_nav16",@"app_home_nav9",@"fh_dd_xq_an111",@"ydlb_an2",@"ydlb_an4",@"fh_dd_xq_an7",@"ydxq_an3",@"ydxq_an4",@"fh_an1",@"fh_dd_xq_an17",@"cyfbj_an3",@"cyfbj_an4",@"cyf_in_an3"];
    }
    return self;
}

-(void)setType:(NSInteger)type{
    _type=type;
   
    if (type<10) {//右边的图片

        [self.unitTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 22));
        
        }];
        [self.unitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(0);
            make.size.mas_offset(CGSizeMake(20, 20));
            make.top.offset(4);
        }];
        //[self.unitImageView setImage:[UIImage imageNamed:_rightImageArr[type]]];
        self.unitTextLabel.textAlignment=NSTextAlignmentRight;
    }else{
        
        [self.unitTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(0, 25, 0, 0));
        }];
        [self.unitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.size.mas_offset(CGSizeMake(20, 20));
            make.top.offset(4);
        }];
        self.unitTextLabel.textAlignment=NSTextAlignmentLeft;
        //[self.unitImageView setImage:[UIImage imageNamed:_leftImageArr[type-10]]];
    }
}
-(void)setLabelText:(NSString*)text{
    
    self.unitTextLabel.text=text;

}
-(void)setImageView:(NSString*)imageName{

    self.unitImageView.image = [UIImage imageNamed:imageName];
}
@end
