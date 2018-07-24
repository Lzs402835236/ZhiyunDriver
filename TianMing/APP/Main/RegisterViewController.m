//
//  RegisterViewController.m
//  TimeMemory
//
//  Created by 李智帅 on 16/9/13.
//  Copyright © 2016年 李智帅. All rights reserved.
//

#import "RegisterViewController.h"
#import "MainPageViewController.h"
#import "LeftSlideViewController.h"
#import "LeftSortsViewController.h"
#import "OtherViewController.h"
@interface RegisterViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong) UITextField * phoneNumber;
@property(nonatomic,strong) UITextField * maTextField;
@property(nonatomic,copy) NSString * str2;
@property(nonatomic,strong)UIButton * getMaBtn;
@property(nonatomic,retain)UIPanGestureRecognizer * recog;
@property(nonatomic,strong)UINavigationController *mainNavigationController;
@property(nonatomic,strong)UIButton * nextBtn;
@property(nonatomic,strong)UIButton * checkBtn;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MAINCOLOR;
    self.recog = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardHide:)];
    self.recog.delegate = self;
    [self.view addGestureRecognizer:self.recog];
    [self createNav];
    [self detailUI];
    [self maView];
    [self  next];
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
//    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
//    tapGestureRecognizer.cancelsTouchesInView = NO;
//    //将触摸事件添加到当前view
//    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
#pragma mark - 手势delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer{

    return NO;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"tel"]) {
        
        MainPageViewController * mainVC = [[MainPageViewController alloc]init];
        //    [[NSUserDefaults standardUserDefaults]setObject:self.phoneNumber.text forKey:@"tel"];
        [self.navigationController pushViewController:mainVC animated:NO];
    }
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.phoneNumber resignFirstResponder];
    [self.maTextField resignFirstResponder];
}
#pragma mark - next
- (void)next{

    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn = nextBtn;
    //self.nextBtn.enabled = NO;
    nextBtn.frame = CGRectMake(25, 220, SCREEN_W - 50, 30);
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"but_red"] forState:UIControlStateNormal];
    [nextBtn setTitle:@"下一步" forState: UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    self.checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkBtn setImage:[UIImage imageNamed:@"cyf_bjxq_an2-1"] forState:UIControlStateNormal];
    [self.checkBtn setImage:[UIImage imageNamed:@"cyf_bjxq_an2"] forState:UIControlStateSelected];
    self.checkBtn.frame = CGRectMake(25, 267.5, 20, 20);
    [self.checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.checkBtn.selected = YES;
    [self.view addSubview:self.checkBtn];
    
    UILabel * agreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 270, SCREEN_W-70, 20)];
    agreeLabel.font = [UIFont systemFontOfSize:13];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapNext)];
    [agreeLabel addGestureRecognizer:tap];
    agreeLabel.userInteractionEnabled = YES;
    agreeLabel.textAlignment = NSTextAlignmentLeft;
    agreeLabel.text = @"我已阅读并同意 《智运物流平台服务协议》";
    agreeLabel.textColor = [UIColor redColor];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:agreeLabel.text];
    NSRange daryGray = NSMakeRange(0, [[noteStr string] rangeOfString:@" "].location);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:daryGray];
    [agreeLabel setAttributedText:noteStr] ;
    [agreeLabel sizeToFit];
    agreeLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:agreeLabel];
}

#pragma mark - tapNext
- (void)tapNext{
    
    OtherViewController*vc=[[OtherViewController alloc]init];
    vc.titleStr=@"智运物流平台服务协议";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - checkBtnClick
- (void)checkBtnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.nextBtn.enabled = YES;
    }else{
        
        self.nextBtn.enabled = NO;
        
    }
}

#pragma mark - nextBtnClicked

- (void)nextBtnClicked:(UIButton * )nextBtn{
    if (self.maTextField.text.length !=0&&self.phoneNumber.text.length !=0) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        NSLog(@"deviceToken%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"]);
        [dict setObject:self.phoneNumber.text forKey:@"mobile"];
        [dict setObject:self.maTextField.text forKey:@"code"];
        //[dict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"] forKey:@"recentDeviceId"];
        [dict setObject:@"IOS" forKey:@"recentDeviceType"];
        //    NSDictionary * dic = @{@"mobile":self.phoneNumber.text,@"code":self.maTextField.text};
        [[HttpRequest sharedClient]httpRequestPOST:Register parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            //        NSString * str  ;
            if ([responseObject[@"success"] integerValue] ==1) {
                Toast(@"获取成功");
                //[self openCountdown];
                [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"mobile"] forKey:@"tel"];
                [self nextViewController];
                
            }else{
                
                Toast(responseObject[@"info"]);
            }
            //        [self registerPhone:str];
            NSLog(@"responseObject%@",responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            Toast(@"获取失败");
            
        }];
    }else{
    
        Toast(@"有空未填");
    }
    
}

- (void)nextViewController{

    //LeftSlideViewController * vc = [[LeftSlideViewController alloc]init];
    //LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
    /** 创建通知，一旦得到登录状态改变，则重新创建tableView*/
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeTel" object:nil];
    MainPageViewController * mainVC = [[MainPageViewController alloc]init];
    
//    LeftSlideViewController *vc = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
//    
//    self.view.window.rootViewController =vc;
    //[[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
//    [[NSUserDefaults standardUserDefaults]setObject:self.phoneNumber.text forKey:@"tel"];
    [self.navigationController pushViewController:mainVC animated:NO];
}

#pragma mark - createNav
- (void)createNav{
    
    self.titleLabel.text = @"登录";
    self.titleLabel.textColor = [UIColor colorWithRed:46/255.0 green:46/255.0 blue:46/255.0 alpha:1];
//    [self.leftButton setImage:[UIImage imageNamed:@"btn_left"] forState:UIControlStateNormal];
//    [self.leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)detailUI{

    UIView * detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 120)];
    detailView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:detailView];
    
    UILabel * countryLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 40)];
    countryLabel.text = @"国家地区";
    countryLabel.textColor = [UIColor blackColor];
    countryLabel.textAlignment = NSTextAlignmentLeft;
    [detailView addSubview:countryLabel];
    
    UIButton * countryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [countryBtn setTitle:@"中国+86 >" forState:UIControlStateNormal];
    [countryBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    countryBtn.frame = CGRectMake(SCREEN_W - 110, 10, 100, 40);
    [countryBtn addTarget:self action:@selector(countryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [detailView addSubview:countryBtn];
    
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(20, 60, SCREEN_W - 40, 1)];
    lineView.backgroundColor = [UIColor darkGrayColor];
    [detailView addSubview:lineView];
    
    UILabel * telLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 80, 40)];
    telLabel.textAlignment = NSTextAlignmentLeft;
    telLabel.text = @"手机号";
    telLabel.textColor = [UIColor blackColor];
    [detailView addSubview:telLabel];
    
    self.phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(110, 70, 180, 40)];
    self.phoneNumber.textColor = [UIColor blackColor];
    
    self.phoneNumber.placeholder = @"请输入手机号";
    self.phoneNumber.textAlignment = NSTextAlignmentLeft;
    self.phoneNumber.borderStyle = UITextBorderStyleNone;
    
    [detailView addSubview:self.phoneNumber];
    
}

- (void)countryBtnClick:(UIButton *)countryBtn{

    NSLog(@"点击了国家地区");
}

- (void)maView{

    UIView * maView = [[UIView alloc]initWithFrame:CGRectMake(0, 140, SCREEN_W, 60)];
    maView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:maView];
    
    UILabel * maLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 40)];
    maLabel.textAlignment = NSTextAlignmentLeft;
    maLabel.text = @"校验码";
    maLabel.textColor = [UIColor blackColor];
    [maView addSubview:maLabel];
    
    UITextField * maTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 10, 120, 40)];
    self.maTextField = maTextField;
    maTextField.placeholder = @"短信校验码";
    maTextField.textColor = [UIColor blackColor];
    maTextField.borderStyle = UITextBorderStyleNone;
    [maView addSubview:maTextField];
    maTextField.textAlignment = NSTextAlignmentLeft;
    
    UIButton * getMaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getMaBtn.frame = CGRectMake(SCREEN_W - 120, 10, 100, 40);
    [getMaBtn setTitle:@"获取校验码" forState:UIControlStateNormal];
    [getMaBtn addTarget:self action:@selector(getClicked:) forControlEvents:UIControlEventTouchUpInside];
    [getMaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.getMaBtn = getMaBtn;
    [maView addSubview:getMaBtn];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W - 122, 20, 2, 20)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    [maView addSubview:lineView];
    
}

#pragma mark - getClicked:
- (void)getClicked:(UIButton *)getBtn{

    NSLog(@"点击了获取验证码");
    
    
    if ([self checkTel:self.phoneNumber.text]) {
        NSDictionary * dic = @{@"toMobile":self.phoneNumber.text};
        [[HttpRequest sharedClient]httpRequestPOST:Login parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            //NSString * str  ;
            
            if ([responseObject[@"success"] integerValue] ==1) {
                Toast(@"获取成功");
                [self openCountdown];
                
            }
            //[self registerPhone:str];
            NSLog(@"responseObject%@",responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"%@",error);
        }];
        
        
    }else{
    
        Toast(@"手机号输入有误请重新输入");
    }
}
// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.getMaBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                //                [self.getMaBtn setTitleColor:[UIColor colorFromHexCode:@"FB8557"] forState:UIControlStateNormal];
                self.getMaBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.getMaBtn setTitle:[NSString stringWithFormat:@"发送中(%.2ds)", seconds] forState:UIControlStateNormal];
                //[self.getMaBtn setTitleColor:[UIColor colorFromHexCode:@"979797"] forState:UIControlStateNormal];
                self.getMaBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)registerPhone:(NSString *)str{

    
    //获取验证码倒计时
    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    NSDictionary * dic = @{@"mobile":self.phoneNumber.text,@"code":self.maTextField.text};
//    NSLog(@"%@",self.phoneNumber.text);
//    
//            [manager POST:Register parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
//    
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"responseObject%@",responseObject);
////                NSDictionary * data = responseObject[@"data"];
////                self.maStr = data[@"code"];
//    
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    
//                NSLog(@"%@错误", error);
//            }];
    
//    if ([str integerValue]==1) {
//        
//        //Toast(@"该手机已经注册过");
//        return ;
//    }else{
//        
//        //Toast(@"已将验证码发出");
//        //获取验证码倒计时
//        [self openCountdown];
//        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//        
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//        NSDictionary * dic = @{@"phone":self.phoneNumber.text};
//        NSLog(@"%@",self.phoneNumber.text);
//        
////        [manager POST:Register parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
////            
////        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////            NSLog(@"%@",responseObject);
////            NSDictionary * data = responseObject[@"data"];
////            self.maStr = data[@"code"];
////            
////        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
////            
////            NSLog(@"%@错误", error);
////        }];
//        
//    }
}
//判断手机号是不是有效
- (BOOL)checkTel:(NSString *)str
{
    if ([str length] == 0)
    {
        
//                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号不能为空" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
//        
//                [alert show];
         //Toast(@"手机号不能为空");
        
        return NO;
        
    }
    
    // NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSString *regex = @"^((14[0-9])|(17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch)
    {
        
//                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入有效的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        
//                [alert show];
        //Toast(@"您输入的手机号码有误请重新输入");
        
        
        return NO;
        
    }
    
    else
    {
        
        return YES;
    }
    
}

#pragma mark - returnClick:
- (void)returnClick:(UIButton *)reBtn{

    [self dismissViewControllerAnimated:YES completion:nil];
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
