//
//  CheckImageViewController.m
//  TianMing
//
//  Created by 李智帅 on 17/3/21.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "CheckImageViewController.h"
#import "BDImagePicker.h"

@interface CheckImageViewController ()
@property (nonatomic,strong)UIImageView * imgView7;
@property (nonatomic,strong)UIImageView * imgView8;
@property (nonatomic,strong)UIImageView * imgView9;
@property (nonatomic,strong)UIButton * imageBtn7;
@property (nonatomic,strong)UIButton * imageBtn8;
@property (nonatomic,strong)UIButton * imageBtn9;
@property (nonatomic,strong)UIButton * submitBtn;

@end

@implementation CheckImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createUI];
    //[self createData];
    self.view.backgroundColor = MAINCOLOR;
    // Do any additional setup after loading the view.
}
#pragma mark - 图片选择点击
- (void)selectBtnClick:(UIButton *)btn{
    
    __weak typeof(self) weakSelf = self;
    
    //btn.tag = i++;
    
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            if (btn.tag==7) {
                
                self.imgView7.image = image;
                
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
    
    NSData * imageData = UIImageJPEGRepresentation(photo,0.2);
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
            //[self submitPhoto];
            
        }else if (tag==8){
            
            self.imgStr2 = result;
            //[self submitPhoto];
        }else if(tag ==9){
            
            self.imgStr3 = result;
            //[self submitPhoto];
        }
        NSLog(@"result%@",result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error%@",error);
    }];
}
#pragma mark - submitPhoto
- (void)submitPhoto{
    
    
    NSDictionary * dic = @{@"id":self.mainId,@"imageUrls":[NSString stringWithFormat:@"%@|%@|%@",self.imgStr1,self.imgStr2,self.imgStr3],@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]};
    NSLog(@"dic%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:UploadURL parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"运单详情%@",responseObject);
        if ([responseObject[@"success"] integerValue]==1) {
            Toast(@"上传成功");
            UIViewController *vc = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:vc animated:YES];
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

- (UIButton *)submitBtn{

    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(SCREEN_W/2-80,self.imageBtn9.frame.size.height+self.imageBtn9.frame.origin.y +5, 160, 30);
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"blue_an1"] forState:UIControlStateNormal];
        [_submitBtn setTitleColor:WC forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitPhoto) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitBtn];
    }
    return _submitBtn;
}

- (UIButton *)imageBtn7{

    if (!_imageBtn7) {
        _imageBtn7 = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn7.frame = CGRectMake(SCREEN_W/2-80,self.imgView7.frame.size.height+self.imgView7.frame.origin.y +10, 160,25);
        [_imageBtn7 setBackgroundImage:[UIImage imageNamed:@"greenBtn"] forState:UIControlStateNormal];
        [_imageBtn7 setTitle:@"发货工单" forState:UIControlStateNormal];
        [_imageBtn7 setTitleColor:WC forState:UIControlStateNormal];
        [_imageBtn7 addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _imageBtn7.tag = 7;
        
    }
    return _imageBtn7;
}

- (UIButton *)imageBtn8{
    
    if (!_imageBtn8) {
        _imageBtn8 = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn8.frame = CGRectMake(SCREEN_W/2-80,self.imgView8.frame.size.height+self.imgView8.frame.origin.y +10, 160, 30);
        [_imageBtn8 setBackgroundImage:[UIImage imageNamed:@"greenBtn"] forState:UIControlStateNormal];
        [_imageBtn8 setTitle:@"收货工单" forState:UIControlStateNormal];
        [_imageBtn8 setTitleColor:WC forState:UIControlStateNormal];
        [_imageBtn8 addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _imageBtn8.tag = 8;
    }
    return _imageBtn8;
}

- (UIButton *)imageBtn9{
    
    if (!_imageBtn9) {
        _imageBtn9 = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn9.frame = CGRectMake(SCREEN_W/2-80,self.imgView9.frame.size.height+self.imgView9.frame.origin.y +5, 160, 30);
        [_imageBtn9 setBackgroundImage:[UIImage imageNamed:@"greenBtn"] forState:UIControlStateNormal];
        [_imageBtn9 setTitle:@"车辆正面(含车牌号)" forState:UIControlStateNormal];
        [_imageBtn9 setTitleColor:WC forState:UIControlStateNormal];
        [_imageBtn9 addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _imageBtn9.tag = 9;
    }
    return _imageBtn9;
}
- (UIImageView * )imgView7{

    if (!_imgView7) {
        _imgView7 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, SCREEN_W-10, SCREEN_H/3-50)];
        _imgView7.layer.borderColor = [UIColor blackColor].CGColor;
        _imgView7.layer.borderWidth = 0.5;
        [self.view addSubview:_imgView7];
    }
    return _imgView7;
}
- (UIImageView * )imgView8{
    
    if (!_imgView8) {
        _imgView8 = [[UIImageView alloc]initWithFrame:CGRectMake(5,SCREEN_H/3, SCREEN_W-10, SCREEN_H/3-50)];
        _imgView8.layer.borderColor = [UIColor blackColor].CGColor;
        _imgView8.layer.borderWidth = 0.5;
        [self.view addSubview:_imgView8];
    }
    return _imgView8;
}
- (UIImageView * )imgView9{
    
    if (!_imgView9) {
        _imgView9 = [[UIImageView alloc]initWithFrame:CGRectMake(5,SCREEN_H/3 *2, SCREEN_W-10, SCREEN_H/3-80)];
        _imgView9.layer.borderColor = [UIColor blackColor].CGColor;
        _imgView9.layer.borderWidth = 0.5;
        [self.view addSubview:_imgView9];
    }
    return _imgView9;
}

#pragma mark - createData
- (void)createData{

    NSDictionary * dic = @{@"orderDetailsNum":@1,@"pageNumber":@1,@"pageSize":@1};
    
    [[HttpRequest sharedClient]httpRequestPOST:HomeUrl parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //NSLog(@"运单详情%@",responseObject);
//        HomeModel*model1=[[HomeModel alloc]init];
//        NSArray*arr=responseObject[@"data"][@"list"];
//        if (!isNull(arr)) {
//            model1=[HomeModel objectWithKeyValues:responseObject[@"data"][@"list"][0]];
//            [self createModel:model1];
//        }
        NSLog(@"responseObject%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}
#pragma mark - checkImage
- (void)checkImage{

    [self.imgView7 sd_setImageWithURL:[NSURL URLWithString:self.imgStr1]];
    [self.imgView8 sd_setImageWithURL:[NSURL URLWithString:self.imgStr2]];
    [self.imgView9 sd_setImageWithURL:[NSURL URLWithString:self.imgStr3]];
    
}
#pragma mark - createUI
- (void)createUI{

    //self.imgView7.image = [UIImage imageNamed:@"yige.jpg"];
    //self.imgView8.image = [UIImage imageNamed:@"yige2.jpg"];
    //self.imgView9.image = [UIImage imageNamed:@"yige3.jpg"];
    if ([self.statusStr isEqualToString:@"已完成"]||[self.statusStr isEqualToString:@"待确认"]) {
        
        
        [self.view addSubview:self.imageBtn9];
        [self.view addSubview:self.imageBtn7];
        [self.view addSubview:self.imageBtn8];
        //[self.submitBtn setTitle:@"凭证" forState:UIControlStateNormal];
        //[self.view addSubview:self.submitBtn];
        self.imageBtn9.userInteractionEnabled = NO;
        self.imageBtn8.userInteractionEnabled = NO;
        self.imageBtn7.userInteractionEnabled = NO;
        [self checkImage];
    }else if ([self.statusStr isEqualToString:@"运输中"]){
    
        [self.view addSubview:self.imageBtn9];
        [self.view addSubview:self.imageBtn7];
        [self.view addSubview:self.imageBtn8];
        [self.submitBtn setTitle:@"上传凭证" forState:UIControlStateNormal];
        [self.view addSubview:self.submitBtn];
    }
    
    

}

#pragma mark - createNav
- (void)createNav{
    
    self.titleLabel.text = self.titleStr;
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
