//
//  HowClassMode.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "HowClassMode.h"

@implementation HowClassMode
+(instancetype)howClassModeWithDic:(NSDictionary *)dic{
//    "error_code": "200",
//    "reason": "success!",
//    "result":
//    [
//     {
//         "how_id": "195",
//         "class_id": "2",
//         "class_name": "二年级一班",
//         "teacher_id": "2"
//     },
//   
    HowClassMode *mode = [[self alloc]init];
    
    
    mode.how_id = dic[@"how_id"];
    mode.class_name = dic[@"class_name"];
    mode.class_id = dic[@"class_id"];
    mode.teacher_id = dic[@"teacher_id"];
    return mode;
}
@end
