//
//  HomeModel.m
//  TianMing
//
//  Created by 李智帅 on 17/2/20.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    
}
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"mainId" : @"id"};
}
@end
