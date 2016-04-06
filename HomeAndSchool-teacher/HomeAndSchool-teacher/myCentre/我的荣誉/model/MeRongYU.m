//
//  MeRongYU.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MeRongYU.h"

@implementation MeRongYU

+(instancetype)memodeWithDic:(NSDictionary *)dic{
    
    MeRongYU *mode = [[self alloc]init];
    mode.yongyu_time = dic[@"rongyu_time"];
    
    mode.rongyu_content = dic[@"rongyu_content"];
    
 
    //},
        
    return mode;
}

@end
