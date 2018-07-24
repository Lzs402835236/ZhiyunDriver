//
//  SetTableViewCell.m
//  TimeMemory
//
//  Created by 李智帅 on 16/9/26.
//  Copyright © 2016年 李智帅. All rights reserved.
//

#import "SetTableViewCell.h"

@implementation SetTableViewCell
+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView{
    
    static NSString * setReused = @"acountCell";
    
    SetTableViewCell * setCell = [tableView dequeueReusableCellWithIdentifier:setReused];
    if (!setCell){
        setCell = [[SetTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:setReused];
        setCell.backgroundColor = [UIColor whiteColor];
        setCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return setCell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    
    
    
    
    
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height-0.5, rect.size.width, 0.5));
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
