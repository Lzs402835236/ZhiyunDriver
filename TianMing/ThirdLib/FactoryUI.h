//
//  FactoryUI.h
//  LoveLife
//
//  Created by qianfeng on 16/4/25.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FactoryUI : NSObject

//利用工厂模式将基本控件用静态方法创建,使得能够更方便的修改类似的属性

//UIView
+(UIView *)createViewFrame:(CGRect)frame;
//UILabel
+(UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;
//UIButton
+(UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName target:(id)target selector:(SEL)selector;
+(UIButton *)createButtonWithtitle:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName target:(id)target selector:(SEL)selector;
//UIImageView
+(UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;
//UITextField
+(UITextField *)createTextFieldWithFrame:(CGRect)frame text:(NSString *)text placeHolder:(NSString *)placeHolder;

@end
