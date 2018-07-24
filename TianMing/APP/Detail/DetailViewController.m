//
//  DetailViewController.m
//  TianMing
//
//  Created by 李智帅 on 17/1/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "DetailViewController.h"
#import "HomeModel.h"
#import "BDImagePicker.h"
#import "CheckImageViewController.h"
@interface DetailViewController ()
{

    
}
@property (nonatomic,strong)UIView * firstView2;
@property (nonatomic,strong)UIView * secondView2;
@property (nonatomic,strong)UIView * thirdView2;
@property (nonatomic,strong)UIButton * uploadBtn;
@property (nonatomic,strong)UIButton * checkBtn;
@property (nonatomic,strong)UIImageView * imgView7;
@property (nonatomic,strong)UIImageView * imgView8;
@property (nonatomic,strong)UIImageView * imgView9;
@property (nonatomic,copy)NSString *imgStr1;
@property (nonatomic,copy)NSString *imgStr2;
@property (nonatomic,copy)NSString *imgStr3;
@property (nonatomic,strong)UIView * whiteView;

@end

@implementation DetailViewController

int i = 7;
- (void)createData{
    
    
    NSDictionary * dic = @{@"orderDetailsNum":self.orderDetailsNum,@"pageNumber":@1,@"pageSize":@1};
    //NSLog(@"%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:HomeUrl parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"运单详情%@",responseObject);
        HomeModel*model1=[[HomeModel alloc]init];
        NSArray*arr=responseObject[@"data"][@"list"];
        if (!isNull(arr)) {
            model1=[HomeModel objectWithKeyValues:responseObject[@"data"][@"list"][0]];
            if (model1) {
                [self createModel:model1];
            }else{
            
                Toast(@"数据出现未知错误");
            }
            
        }
        //NSLog(@"responseObject%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

- (void)createModel:(HomeModel *)model{

    self.whiteView.backgroundColor = WC;
    self.waybillIMG.image = [UIImage imageNamed:@"ynh"];
    self.waybillLabel.text = [NSString stringWithFormat:@"运单号: %@",model.orderDetailsNum];
    
    self.sendIMG.image  =[UIImage imageNamed:@"ydxq_an3"];
    self.secondView.backgroundColor = MAINCOLOR;
    //self.secondView2.backgroundColor = MAINCOLOR;
    self.sendInfoLabel.text = @"发货人信息";
    self.sendNameLabel.text = [NSString stringWithFormat:@"姓名: %@",model.tenderName];
    self.sendTelLabel.text = [NSString stringWithFormat:@"电话: %@",model.tenderTel];
    self.getAdressLabel.text = [NSString stringWithFormat:@"起点: %@%@%@",model.outProvince,model.outCity,model.outCounty];
    self.thirdView.backgroundColor = MAINCOLOR;
    self.thirdView2.backgroundColor = MAINCOLOR;
    self.forthView.backgroundColor = MAINCOLOR;
    self.getIMG.image = [UIImage imageNamed:@"ydxq_an4"];
    self.getInfoLabel.text = @"收货人信息";
    self.getNameLabel.text = [NSString stringWithFormat:@"姓名: %@",model.receiveName];
    self.getTelLabel.text = [NSString stringWithFormat:@"电话: %@",model.receiveTel];
    self.sendAddressLab.text = [NSString stringWithFormat:@"终点: %@%@%@",model.receiveProvince,model.receiveCity,model.receiveCounty];
    self.fifthView.backgroundColor = MAINCOLOR;
    self.sixthView.backgroundColor = MAINCOLOR;
    self.goodsIMG.image = [UIImage imageNamed:@"hy"];
    self.goodsInfoLab.text = @"货物信息";
    self.goodsCategoryLab.text = [NSString stringWithFormat:@"货物类型: %@",model.goodsType];
    self.heightLab.text = [NSString stringWithFormat:@"重量: %.2f%@",model.actualNum,model.sizeUnit];
    self.volumeLab.text = [NSString stringWithFormat:@"体积: %@",model.goodsSize];
    self.discripLab.text = [NSString stringWithFormat:@"描述: %@",model.remarks];
    //self.seventhView.backgroundColor = MAINCOLOR;
    //[self.getGoodsBtn setTitle:@"去装货" forState:UIControlStateNormal];
    self.transStatus = model.transStatus;
    if ([self.transStatus isEqualToString:@"已取消"]) {
        
        [self.getGoodsBtn setTitle:self.transStatus forState:UIControlStateNormal];
        self.getGoodsBtn.userInteractionEnabled = NO;
        self.uploadBtn.userInteractionEnabled = NO;
        [self.uploadBtn setTitle:@"上传凭证" forState:UIControlStateNormal];
        self.uploadBtn.enabled = NO;
        self.uploadBtn.hidden = NO;
        self.uploadBtn.alpha=0.5; //变暗
        [self.view addSubview:self.uploadBtn];
        
    }else if ([self.transStatus isEqualToString:@"待运输"]){
        
        [self.getGoodsBtn setTitle:@"启运" forState:UIControlStateNormal];
        self.getGoodsBtn.userInteractionEnabled = YES;
        self.uploadBtn.userInteractionEnabled = NO;
        [self.uploadBtn setTitle:@"上传凭证" forState:UIControlStateNormal];
        self.uploadBtn.enabled = NO;
        self.uploadBtn.hidden = NO;
        self.uploadBtn.alpha=0.5; //变暗
        [self.view addSubview:self.uploadBtn];
        
    }else if ([self.transStatus isEqualToString:@"已完成"]){
        if(model.imageUrl.length !=0){
        
            NSArray * tempArr = [model.imageUrl componentsSeparatedByString:@"|"];
            NSLog(@"tempArr.count%lu",(unsigned long)tempArr.count);
            if (tempArr.count !=0) {
                if (tempArr.count ==1) {
                    
                    self.imgStr1 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[0]];
                }else if (tempArr.count ==2){
                
                    self.imgStr1 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[0]];
                    self.imgStr2 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[1]];
                }else{
                
                    self.imgStr1 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[0]];
                    self.imgStr2 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[1]];
                    self.imgStr3 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[2]];
                }
                
                [self.uploadBtn setTitle:@"查看凭证" forState:UIControlStateNormal];
                self.uploadBtn.hidden = NO;
                self.uploadBtn.userInteractionEnabled = YES;
                self.uploadBtn.enabled = YES;
                self.uploadBtn.alpha = 1;
                [self.view addSubview:self.uploadBtn];
            }else{
            
                self.imgStr1 = model.imageUrl;
                [self.uploadBtn setTitle:@"查看凭证" forState:UIControlStateNormal];
                self.uploadBtn.hidden = NO;
                self.uploadBtn.userInteractionEnabled = YES;
                self.uploadBtn.enabled = YES;
                self.uploadBtn.alpha = 1;
                [self.view addSubview:self.uploadBtn];
            }
            
        }
       [self.getGoodsBtn setTitle:self.transStatus forState:UIControlStateNormal];
        self.getGoodsBtn.userInteractionEnabled = NO;
        
    }else if ([self.transStatus isEqualToString:@"运输中"]){
        if(model.imageUrl.length !=0){
            
            NSArray * tempArr = [model.imageUrl componentsSeparatedByString:@"|"];
            NSLog(@"tempArr.count%lu",(unsigned long)tempArr.count);
            if (tempArr.count !=0) {
                if (tempArr.count ==1) {
                    
                    self.imgStr1 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[0]];
                }else if (tempArr.count ==2){
                    
                    self.imgStr1 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[0]];
                    self.imgStr2 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[1]];
                }else{
                    
                    self.imgStr1 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[0]];
                    self.imgStr2 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[1]];
                    self.imgStr3 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[2]];
                }
                
                [self.uploadBtn setTitle:@"查看凭证" forState:UIControlStateNormal];
                self.uploadBtn.hidden = NO;
                self.uploadBtn.alpha = 1;
                [self.view addSubview:self.uploadBtn];
            }else{
                
                self.imgStr1 = model.imageUrl;
                [self.uploadBtn setTitle:@"查看凭证" forState:UIControlStateNormal];
                self.uploadBtn.hidden = NO;
                self.uploadBtn.alpha = 1;
                [self.view addSubview:self.uploadBtn];
            }
            
        }else{
        
            [self.uploadBtn setTitle:@"上传凭证" forState:UIControlStateNormal];
            //[self.view addSubview:self.uploadBtn];
            [self.view addSubview:self.uploadBtn];
        }
         [self.getGoodsBtn setTitle:self.transStatus forState:UIControlStateNormal];
        
        self.getGoodsBtn.userInteractionEnabled = NO;
        
    }else if ([self.transStatus isEqualToString:@"待确认"]){
    
        if(model.imageUrl.length !=0){
            
            NSArray * tempArr = [model.imageUrl componentsSeparatedByString:@"|"];
            NSLog(@"tempArr.count%ld",tempArr.count);
            if (tempArr.count !=0) {
                if (tempArr.count ==1) {
                    
                    self.imgStr1 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[0]];
                }else if (tempArr.count ==2){
                    
                    self.imgStr1 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[0]];
                    self.imgStr2 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[1]];
                }else{
                    
                    self.imgStr1 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[0]];
                    self.imgStr2 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[1]];
                    self.imgStr3 = [NSString stringWithFormat:@"%@%@",model.imageHeadUrl,tempArr[2]];
                }
                
                [self.uploadBtn setTitle:@"查看凭证" forState:UIControlStateNormal];
                self.uploadBtn.hidden = NO;
                [self.view addSubview:self.uploadBtn];
            }else{
                
                self.imgStr1 = model.imageUrl;
                [self.uploadBtn setTitle:@"查看凭证" forState:UIControlStateNormal];
                self.uploadBtn.hidden = NO;
                [self.view addSubview:self.uploadBtn];
            }
            
        }else{
            
            [self.uploadBtn setTitle:@"上传凭证" forState:UIControlStateNormal];
            //[self.view addSubview:self.uploadBtn];
            [self.view addSubview:self.uploadBtn];
        }
        [self.getGoodsBtn setTitle:self.transStatus forState:UIControlStateNormal];
        
        self.getGoodsBtn.userInteractionEnabled = NO;
        
    }
    //self.firstView.backgroundColor = MAINCOLOR;
    //self.waybillIMG.image = [UIImage imageNamed:@"fh_dd_xq_an1-1"];
    self.mainId = model.mainId;
}

#pragma mark - uploadBtnClick
- (void)uploadBtnClick{

    CheckImageViewController * checkVC = [[CheckImageViewController alloc]init];
    checkVC.titleStr = self.uploadBtn.titleLabel.text;
    checkVC.statusStr = self.transStatus;
    checkVC.mainId = self.mainId;
    if ([self.uploadBtn.titleLabel.text isEqualToString:@"查看凭证"]) {
        
        checkVC.imgStr1 = self.imgStr1;
        checkVC.imgStr2 = self.imgStr2;
        checkVC.imgStr3 = self.imgStr3;
        
    }
    [self.navigationController pushViewController:checkVC animated:YES];
    
}

- (void)checkBtnClick{

    CheckImageViewController * checkVC = [[CheckImageViewController alloc]init];
    checkVC.titleStr = self.uploadBtn.titleLabel.text;
    checkVC.statusStr = self.transStatus;
    checkVC.mainId = self.mainId;
    [self.navigationController pushViewController:checkVC animated:YES];
}

#pragma mark - 图片选择点击
- (void)selectBtnClick:(UIButton *)btn{
    
    __weak typeof(self) weakSelf = self;
    
    btn.tag = i++;
    
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            if (btn.tag==7) {
                
                [self.imgView7 setImage:image];
                
            }else if (btn.tag==8){
                
                self.imgView8.image=image;
                
            }else if (btn.tag==9){
                
                self.imgView9.image=image;
                
            }else{
            
                Toast(@"最多只能上传三张");
            }
            NSLog(@"%@",image);
            if (btn.tag <= 9) {
                [weakSelf upDateHeadIcon:image btnTag:btn.tag];
            }
            
        }
    }];
}

#pragma  mark 上传图片
- (void)upDateHeadIcon:(UIImage *)photo btnTag:(NSInteger )tag{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         
                                                         @"text/html",
                                                         
                                                         @"image/jpeg",
                                                         
                                                         @"image/png",
                                                         
                                                         @"application/octet-stream",
                                                         
                                                         @"text/json",
                                                         
                                                         nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    
    NSData * imageData = UIImageJPEGRepresentation(photo,0.5);
    NSString * fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"text"];
    [imageData writeToFile:fullPath atomically:NO];
    NSMutableDictionary * dictT = [[NSMutableDictionary alloc]init];
    [dictT setObject:imageData forKey:@"image"];
    
    [manager POST:SeletedPhoto3 parameters:dictT constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"text.jpg" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSData * data = responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        NSLog(@"dic%@",dic);
        NSLog(@"responseObject%@",responseObject);
        NSString * result = dic[@"image"];
        if (tag==7) {
            
            self.imgStr1 = result;
            [self submitPhoto];
            
        }else if (tag==8){
            
            self.imgStr2 = result;
            [self submitPhoto];
        }else if(tag ==9){
            
            self.imgStr3 = result;
            [self submitPhoto];
        }
        NSLog(@"result%@",result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error%@",error);
    }];
}
#pragma mark - submitPhoto
- (void)submitPhoto{
    

    NSDictionary * dic = @{@"id":self.mainId,@"imageUrls":[NSString stringWithFormat:@"%@|%@|%@",self.imgStr1,self.imgStr2,self.imgStr3],@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]};
     //NSLog(@"dic%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:UploadURL parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"运单详情%@",responseObject);
        if ([responseObject[@"success"] integerValue]==1) {
            Toast(@"上传成功");
        }
//        HomeModel*model1=[[HomeModel alloc]init];
//        NSArray*arr=responseObject[@"data"][@"list"];
//        if (!isNull(arr)) {
//            model1=[HomeModel objectWithKeyValues:responseObject[@"data"][@"list"][0]];
//            [self createModel:model1];
//        }
//        NSLog(@"responseObject%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

#pragma mark - lazyLoad
- (UIView * )whiteView{
    
    if (!_whiteView) {
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_W-20, 380)];
        _whiteView.backgroundColor = WC;
        _whiteView.clipsToBounds = YES;
        _whiteView.layer.cornerRadius = 4;
        [self.view addSubview:_whiteView];
    }
    return _whiteView;
}
- (UIButton *)uploadBtn{

    if (!_uploadBtn) {
        _uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _uploadBtn.frame = CGRectMake(SCREEN_W/2+15, 430, 100, 30);
        //[_uploadBtn setBackgroundImage:[UIImage imageNamed:@"blue_an1"] forState:UIControlStateNormal];
        [_uploadBtn setBackgroundColor:[UIColor colorWithRed:241/255.0 green:102/255.0 blue:35/255.0 alpha:1]];
        //[_uploadBtn setTitle:@"上传凭证" forState:UIControlStateNormal];
        [_uploadBtn addTarget:self action:@selector(uploadBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_uploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _uploadBtn.clipsToBounds = YES;
        _uploadBtn.layer.cornerRadius = 16;
        _uploadBtn.layer.borderColor = [UIColor colorWithRed:241/255.0 green:102/255.0 blue:35/255.0 alpha:1].CGColor;
        _uploadBtn.layer.borderWidth= 1;
        [_uploadBtn setTitleColor:WC forState:UIControlStateNormal];
    }
    return _uploadBtn;
}

- (UIButton *)checkBtn{
    
    if (!_checkBtn) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkBtn.frame = CGRectMake(SCREEN_W-120, 480, 100, 20);
        [_checkBtn setBackgroundImage:[UIImage imageNamed:@"blue_an1"] forState:UIControlStateNormal];
        //[_checkBtn setTitle:@"查看凭证" forState:UIControlStateNormal];
        [_checkBtn addTarget:self action:@selector(checkBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_checkBtn setTitleColor:WC forState:UIControlStateNormal];
    }
    return _checkBtn;
}

- (UIView *)firstView{

    if (!_firstView) {
        _firstView = [[UIView alloc]initWithFrame:CGRectMake(0,12, SCREEN_W, 1)];
        //[self.view addSubview:_firstView];
    }
    return _firstView;
}

- (UIImageView *)waybillIMG{

    if (!_waybillIMG) {
        _waybillIMG = [[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 20, 20)];
        //[self.view addSubview:_waybillIMG];
        [_whiteView addSubview:_waybillIMG];
    }
    return _waybillIMG;
}
- (UILabel *)waybillLabel{

    if (!_waybillLabel) {
        _waybillLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 15, SCREEN_W-20, 20)];
        //_waybillLabel.adjustsFontSizeToFitWidth = YES;
        _waybillLabel.font = [UIFont boldSystemFontOfSize:15];
        _waybillLabel.textColor = [UIColor lightGrayColor];
        _waybillLabel.textAlignment = NSTextAlignmentLeft;
        //[self.view addSubview:_waybillLabel];
        [_whiteView addSubview:_waybillLabel];
    }
    return _waybillLabel;
}

- (UIView *)firstView2{
    
    if (!_firstView2) {
        _firstView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 38, SCREEN_W, 1)];
        //[self.view addSubview:_firstView2];
    }
    return _firstView2;
}

- (UIView *)secondView{

    if (!_secondView) {
        _secondView = [[UIView alloc]initWithFrame:CGRectMake(0,58, SCREEN_W, 1)];
        //[self.view addSubview:_secondView];
    }
    return _secondView;
}
- (UIImageView *)sendIMG{
    
    if (!_sendIMG) {
        _sendIMG = [[UIImageView alloc]initWithFrame:CGRectMake(5,61, 20, 20)];
        //[self.view addSubview:_sendIMG];
        [_whiteView addSubview:_sendIMG];
    }
    return _sendIMG;
}
- (UILabel *)sendInfoLabel{

    if (!_sendInfoLabel) {
        _sendInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 61, SCREEN_W-20, 20)];
        _sendInfoLabel.adjustsFontSizeToFitWidth = YES;
        _sendInfoLabel.font = [UIFont boldSystemFontOfSize:15];
        _sendInfoLabel.textAlignment = NSTextAlignmentLeft;
        _sendInfoLabel.textColor = [UIColor blackColor];
        //[self.view addSubview:_sendInfoLabel];
        [_whiteView addSubview:_sendInfoLabel];
    }
    return _sendInfoLabel;
}

- (UILabel *)sendNameLabel{

    if (!_sendNameLabel) {
        _sendNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,91, (SCREEN_W-20)/2, 20)];
        _sendNameLabel.adjustsFontSizeToFitWidth = YES;
        _sendNameLabel.font = Font(15);
        _sendNameLabel.textColor = [UIColor lightGrayColor];
        _sendNameLabel.textAlignment = NSTextAlignmentLeft;
        //[self.view addSubview:_sendNameLabel];
        [_whiteView addSubview:_sendNameLabel];
    }
    return _sendNameLabel;
}

- (UILabel *)sendTelLabel{

    if (!_sendTelLabel) {
        _sendTelLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_W-20)/2, 91, (SCREEN_W-20)/2, 20)];
        _sendTelLabel.adjustsFontSizeToFitWidth = YES;
        _sendTelLabel.font = Font(15);
        _sendTelLabel.textAlignment = NSTextAlignmentLeft;
        _sendTelLabel.textColor = [UIColor lightGrayColor];
        //[self.view addSubview:_sendTelLabel];
        [_whiteView addSubview:_sendTelLabel];
    }
    return _sendTelLabel;
}
//装货地址
- (UILabel *)getAdressLabel{

    if (!_getAdressLabel) {
        _getAdressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,115, SCREEN_W-20, 20)];
        _getAdressLabel.adjustsFontSizeToFitWidth = YES;
        _getAdressLabel.font = Font(15);
        _getAdressLabel.textColor = [UIColor lightGrayColor];
        _getAdressLabel.textAlignment = NSTextAlignmentLeft;
        //[self.view addSubview:_getAdressLabel];
        [_whiteView addSubview:_getAdressLabel];
    }
    return _getAdressLabel;
}

- (UIView *)secondView2{
    
    if (!_secondView2) {
        _secondView2 = [[UIView alloc]initWithFrame:CGRectMake(0,124, SCREEN_W, 1)];
        //[self.view addSubview:_secondView2];
    }
    return _secondView2;
}

- (UIView *)thirdView{
    
    if (!_thirdView) {
        _thirdView = [[UIView alloc]initWithFrame:CGRectMake(0,144, SCREEN_W, 1)];
        [self.view addSubview:_thirdView];
    }
    return _thirdView;
}

- (UIView *)forthView{
    
    if (!_forthView) {
        _forthView = [[UIView alloc]initWithFrame:CGRectMake(0, 109, SCREEN_W, 1)];
        _forthView.backgroundColor = [UIColor blackColor];
        //[_whiteView addSubview:_forthView];
    }
    return _forthView;
}

- (UIImageView *)getIMG{
    
    if (!_getIMG) {
        _getIMG = [[UIImageView alloc]initWithFrame:CGRectMake(5, 147, 20, 20)];
        //[self.view addSubview:_getIMG];
        [_whiteView addSubview:_getIMG];
    }
    return _getIMG;
}

- (UILabel * )getInfoLabel{

    if (!_getInfoLabel) {
        _getInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 147, SCREEN_W-20, 20)];
        _getInfoLabel.font =[UIFont boldSystemFontOfSize:15];
        _getInfoLabel.textAlignment = NSTextAlignmentLeft;
        _getInfoLabel.textColor = [UIColor blackColor];
        _getInfoLabel.adjustsFontSizeToFitWidth = YES;
        //[self.view addSubview:_getInfoLabel];
        [_whiteView addSubview:_getInfoLabel];
    }
    return _getInfoLabel;
}

- (UILabel *)getNameLabel{

    if (!_getNameLabel) {
        _getNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 177, (SCREEN_W-20)/2, 20)];
        _getNameLabel.adjustsFontSizeToFitWidth = YES;
        _getNameLabel.font =Font(15);
        _getNameLabel.textColor = [UIColor lightGrayColor];
        _getNameLabel.textAlignment = NSTextAlignmentLeft;
        //[self.view addSubview:_getNameLabel];
        [_whiteView addSubview:_getNameLabel];
    }
    return _getNameLabel;
}

- (UILabel *)getTelLabel{

    if (!_getTelLabel) {
        _getTelLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_W-20)/2, 177, (SCREEN_W-20)/2, 20)];
        _getTelLabel.adjustsFontSizeToFitWidth =YES;
        _getTelLabel.font = Font(15);
        _getTelLabel.textAlignment = NSTextAlignmentLeft;
        _getTelLabel.textColor = [UIColor lightGrayColor];
        //[self.view addSubview:_getTelLabel];
        [_whiteView addSubview:_getTelLabel];
    }
    return _getTelLabel;
}
//卸货地址
- (UILabel *)sendAddressLab{

    if (!_sendAddressLab) {
        _sendAddressLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 202, SCREEN_W - 20, 20)];
        _sendAddressLab.textColor = [UIColor lightGrayColor];
        _sendAddressLab.textAlignment = NSTextAlignmentLeft;
        _sendAddressLab.font = Font(15);
        _sendAddressLab.adjustsFontSizeToFitWidth = YES;
        //[self.view addSubview:_sendAddressLab];
        [_whiteView addSubview:_sendAddressLab];
    }
    return _sendAddressLab;
}

- (UIView *)thirdView2{
    
    if (!_thirdView2) {
        _thirdView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 227, SCREEN_W, 1)];
        _thirdView2.backgroundColor = [UIColor blackColor];
        [_whiteView addSubview:_thirdView2];
    }
    return _thirdView2;
}

- (UIView *)sixthView{
    
    if (!_sixthView) {
        _sixthView = [[UIView alloc]initWithFrame:CGRectMake(0, 230, SCREEN_W, 1)];
        //[self.view addSubview:_sixthView];
    }
    return _sixthView;
}

- (UIImageView * )goodsIMG{

    if (!_goodsIMG) {
        _goodsIMG = [[UIImageView alloc]initWithFrame:CGRectMake(5, 233, 20, 20)];
        //[self.view addSubview:_goodsIMG];
        [_whiteView addSubview:_goodsIMG];
    }
    return _goodsIMG;
}

- (UILabel *)goodsInfoLab{

    if (!_goodsInfoLab) {
        _goodsInfoLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 233, SCREEN_W - 20, 20)];
        _goodsInfoLab.adjustsFontSizeToFitWidth = YES;
        _goodsInfoLab.textAlignment = NSTextAlignmentLeft;
        _goodsInfoLab.textColor = [UIColor blackColor];
        _goodsInfoLab.font = [UIFont boldSystemFontOfSize:15];
        //[self.view addSubview: _goodsInfoLab];
        [_whiteView addSubview:_goodsInfoLab];
    }
    return _goodsInfoLab;
}

- (UILabel *)goodsCategoryLab{

    if (!_goodsCategoryLab) {
        _goodsCategoryLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 263, SCREEN_W-20, 20)];
        _goodsCategoryLab.font = Font(15);
        _goodsCategoryLab.textColor = [UIColor lightGrayColor];
        _goodsCategoryLab.textAlignment = NSTextAlignmentLeft;
        _goodsCategoryLab.adjustsFontSizeToFitWidth = YES;
        //[self.view addSubview:_goodsCategoryLab];
        [_whiteView addSubview:_goodsCategoryLab];
    }
    return _goodsCategoryLab;
}

- (UILabel *)heightLab{

    if (!_heightLab) {
        _heightLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 293, SCREEN_W-20, 20)];
        _heightLab.font = Font(15);
        _heightLab.textAlignment = NSTextAlignmentLeft;
        _heightLab.textColor = [UIColor lightGrayColor];
        _heightLab.adjustsFontSizeToFitWidth = YES;
        //[self.view addSubview:_heightLab ];
        [_whiteView addSubview:_heightLab];
    }
    return _heightLab;
    
}

- (UILabel *)volumeLab{

    if (!_volumeLab) {
        _volumeLab = [[UILabel alloc]initWithFrame:CGRectMake(10,323, SCREEN_W-20, 20)];
        _volumeLab.adjustsFontSizeToFitWidth = YES;
        _volumeLab.font = Font(15);
        _volumeLab.textColor = [UIColor lightGrayColor];
        _volumeLab.textAlignment = NSTextAlignmentLeft;
        //[self.view addSubview:_volumeLab];
        [_whiteView addSubview:_volumeLab];
    }
    return _volumeLab;
}

- (UILabel *)discripLab{

    if (!_discripLab) {
        _discripLab = [[UILabel alloc]initWithFrame:CGRectMake(10,353, SCREEN_W - 20, 20)];
        _discripLab.adjustsFontSizeToFitWidth = YES;
        _discripLab.font = Font(15);
        _discripLab.textAlignment = NSTextAlignmentLeft;
        _discripLab.textColor = [UIColor lightGrayColor];
        //[self.view addSubview:_discripLab];
        [_whiteView addSubview:_discripLab];
    }
    return _discripLab;
}

- (UIView *)seventhView{
    
    if (!_seventhView) {
        _seventhView = [[UIView alloc]initWithFrame:CGRectMake(0, 376, SCREEN_W, 1)];
        //[self.view addSubview:_seventhView];
    }
    return _seventhView;
}

- (UIButton * )getGoodsBtn{

    if (!_getGoodsBtn) {
        _getGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getGoodsBtn.frame = CGRectMake(SCREEN_W/2-115, 430, 100, 30) ;
        //[_getGoodsBtn setBackgroundColor:[UIColor lightGrayColor]];
        //[_getGoodsBtn setTitle:@"去装货" forState:UIControlStateNormal];
        //[_getGoodsBtn setBackgroundImage:[UIImage imageNamed:@"blue_an1"] forState:UIControlStateNormal];
        [_getGoodsBtn setTitleColor:[UIColor colorWithRed:241/255.0 green:102/255.0 blue:35/255.0 alpha:1] forState:UIControlStateNormal];
        _getGoodsBtn.clipsToBounds = YES;
        _getGoodsBtn.layer.cornerRadius = 16;
        _getGoodsBtn.layer.borderColor = [UIColor colorWithRed:241/255.0 green:102/255.0 blue:35/255.0 alpha:1].CGColor;
        _getGoodsBtn.layer.borderWidth= 1;
        [_getGoodsBtn addTarget:self action:@selector(getGoodsBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_getGoodsBtn];
    }
    return _getGoodsBtn;
}
#pragma mark - getGoodsBtn
- (void)getGoodsBtnClick{

    NSLog(@"点击了去装货");
    
    NSDictionary * dic = @{@"id":self.mainId,@"opMark":@"1",@"updateBy":Tel};
    NSLog(@"点击了去装货%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:GetGoods parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"运单详情去装货%@",responseObject);
        if ([responseObject[@"success"] integerValue]==1) {
            self.transStatus = @"运输中";
            [self.getGoodsBtn setTitle:@"运输中" forState:UIControlStateNormal];
            self.getGoodsBtn.userInteractionEnabled = NO;
            [self.uploadBtn setTitle:@"上传凭证" forState:UIControlStateDisabled];
            self.uploadBtn.hidden = NO;
            self.uploadBtn.userInteractionEnabled = YES;
            self.uploadBtn.enabled = YES;
            self.uploadBtn.alpha = 1;
            
        
        }else{
        
            Toast(responseObject[@"info"]);
        }
        
//        HomeModel*model1=[[HomeModel alloc]init];
//        NSArray*arr=responseObject[@"data"][@"list"];
//        if (!isNull(arr)) {
//            model1=[HomeModel objectWithKeyValues:responseObject[@"data"][@"list"][0]];
//            [self createModel:model1];
//        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MAINCOLOR;
    [self createNav];
    [self createUI];
    [self createData];
    NSLog(@"运单详情");
}
#pragma mark - createUI
- (void)createUI{

    self.whiteView.backgroundColor = WC;
    self.firstView.backgroundColor = MAINCOLOR;
    self.firstView2.backgroundColor = MAINCOLOR;
    self.waybillIMG.image = [UIImage imageNamed:@"ynh"];
    self.waybillLabel.text = [NSString stringWithFormat:@"运单号: %@",@"花花"];
    
    self.sendIMG.image  =[UIImage imageNamed:@"ydxq_an3"];
    self.secondView.backgroundColor = MAINCOLOR;
    //self.secondView2.backgroundColor = MAINCOLOR;
    self.sendInfoLabel.text = @"发货人信息";
    self.sendNameLabel.text = [NSString stringWithFormat:@"姓名: %@",@"太平洋"];
    self.sendTelLabel.text = [NSString stringWithFormat:@"电话: %@",@"110or911"];
    self.getAdressLabel.text = [NSString stringWithFormat:@"装货地址: %@",@"太平洋北岸"];
    self.thirdView.backgroundColor = MAINCOLOR;
    //self.thirdView2.backgroundColor = MAINCOLOR;
    //self.forthView.backgroundColor = MAINCOLOR;
    self.getIMG.image = [UIImage imageNamed:@"ydxq_an4"];
    self.getInfoLabel.text = @"收货人信息";
    self.getNameLabel.text = [NSString stringWithFormat:@"姓名: %@",@"太平洋南岸"];
    self.getTelLabel.text = [NSString stringWithFormat:@"电话: %@",@"911or110"];
    self.sendAddressLab.text = [NSString stringWithFormat:@"卸货地址: %@",@"太平洋南岸"];
    //self.fifthView.backgroundColor = MAINCOLOR;
    self.sixthView.backgroundColor = MAINCOLOR;
    self.goodsIMG.image = [UIImage imageNamed:@"hy"];
    self.goodsInfoLab.text = @"货物信息";
    self.goodsCategoryLab.text = [NSString stringWithFormat:@"货物类型: %@",@"花花的世界"];
    self.heightLab.text = [NSString stringWithFormat:@"重量: %@",@"花花的鞋子"];
    self.volumeLab.text = [NSString stringWithFormat:@"体积: %@",@"花花的体积"];
    self.discripLab.text = [NSString stringWithFormat:@"描述: %@",@"花花的样子"];
    self.seventhView.backgroundColor = MAINCOLOR;
    //[self.getGoodsBtn setTitle:@"去装货" forState:UIControlStateNormal];
//    [self.getGoodsBtn setBackgroundImage:[UIImage imageNamed:@"ydxq_an1"] forState:UIControlStateNormal];
}
#pragma mark - createNav
- (void)createNav{

    self.titleLabel.text = @"运单详情";
    self.titleLabel.textColor = [UIColor colorWithRed:46/255.0 green:46/255.0 blue:46/255.0 alpha:1];
    [self.leftButton setImage:[UIImage imageNamed:@"btn_left"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - backClick
- (void)backClick{

    [self.navigationController popViewControllerAnimated:YES];
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
