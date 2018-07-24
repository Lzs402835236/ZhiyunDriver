//
//  FactoryUI.m
//  LoveLife
//
//  Created by qianfeng on 16/4/25.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "FactoryUI.h"

@implementation FactoryUI

+(UIView *)createViewFrame:(CGRect)frame{

    UIView *view = [[UIView alloc]initWithFrame:frame];
    
    return view;
}
//UILabel
+(UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font{

    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    //设置统一对齐方式
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
//UIButton
+(UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName target:(id)target selector:(SEL)selector{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =frame;
    button.font=Font(13);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;

}
//UIButton
+(UIButton *)createButtonWithtitle:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName target:(id)target selector:(SEL)selector{
    
    UIButton * button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    button.titleLabel.font=Font(13);
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

//UIImageView
+(UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName{

    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame =frame;
    
    return imageView;
}
//UITextField
+(UITextField *)createTextFieldWithFrame:(CGRect)frame text:(NSString *)text placeHolder:(NSString *)placeHolder{

    UITextField * textField = [[UITextField alloc]initWithFrame:frame];
    
    textField.text =text;
    textField.placeholder = placeHolder;
    return textField;
}
@end
