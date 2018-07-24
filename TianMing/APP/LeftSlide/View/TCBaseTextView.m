//
//  TCBaseTextView.m
//  TCDelivery
//
//  Created by 融合互联-------lisen on 17/2/6.
//
//

#import "TCBaseTextView.h"
@interface TCBaseTextView()
@property(nonatomic,strong)UILabel*textLabel;
@end
@implementation TCBaseTextView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel=[[UILabel alloc]init];
        self.textLabel.font=Font(13);
        self.textLabel.adjustsFontSizeToFitWidth=YES;
        [self addSubview:_textLabel];
        self.textFiled=[[UITextField alloc]init];
        
        self.textFiled.borderStyle = UITextBorderStyleRoundedRect;
        self.textFiled.font=Font(12);
       
        self.textFiled.textAlignment=NSTextAlignmentCenter;

        [self addSubview:_textFiled];
//        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
//        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
//        tapGestureRecognizer.cancelsTouchesInView = NO;
//        //将触摸事件添加到当前view
//        [self addGestureRecognizer:tapGestureRecognizer];
        
    }
    return self;
}

- (void)keyboardHide:(UITapGestureRecognizer *)tap{

    [self.textFiled resignFirstResponder];
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.type==1) {
        self.textLabel.frame=CGRectMake(0, 0,70, self.frameHeight);
        self.textFiled.frame=CGRectMake(80, 0, self.frameWidth-80, self.frameHeight);
    }else if(self.type==2){
        self.textLabel.frame=CGRectMake(0, 0,70, self.frameHeight);
        self.textFiled.frame=CGRectMake(80, 0, self.frameWidth-80, self.frameHeight);
        self.textLabel.textAlignment=NSTextAlignmentRight;
    }else if(self.type==3){
        self.textLabel.frame=CGRectMake(0, 0,70, self.frameHeight);
        self.textFiled.frame=CGRectMake(80, 0, self.frameWidth-80, self.frameHeight);
        self.textLabel.textAlignment=NSTextAlignmentCenter;
    }else{
        self.textLabel.frame=CGRectMake(0, 0, 40, self.frameHeight);
        self.textFiled.frame=CGRectMake(40, 0, self.frameWidth-40, self.frameHeight);
    }
    
}

-(void)setText:(NSString*)text{
    self.textLabel.text=text;
}
@end
