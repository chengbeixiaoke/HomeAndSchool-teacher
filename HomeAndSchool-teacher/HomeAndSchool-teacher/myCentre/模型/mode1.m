//
//  mode1.m
//  JXTSU
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 LYF. All rights reserved.
//

#import "mode1.h"

@implementation mode1
+(instancetype)mode1WithDic:(NSDictionary *)dic{
    mode1 *mode = [[self alloc]init];
   
    
    NSArray *arr = [dic allKeys];
    
    mode.name = arr[0];
    mode.valu = dic[arr[0]];
    
    
    return mode;
}


@end
