//
//  ClassMode.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "ClassMode.h"

@implementation ClassMode


+(instancetype)classModeWithDic:(NSDictionary *)dic{
    
    ClassMode *mode = [[self alloc]init];
    
    mode.class_id = dic[@"class_id"];
    mode.class_name = dic[@"class_name"];
    
    
    return mode;
}
@end
