//
//  RYModel.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/1.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "RYModel.h"

@implementation RYModel

+(instancetype)modeWithDic:(NSDictionary *)dic{
    
    RYModel *mode = [[self alloc]init];
    mode.yongyu_time = dic[@"rongyu_time"];

    mode.rongyu_content = dic[@"rongyu_content"];
    
    mode.classid = [dic[@"iuu_class_class_id"] intValue];
    
    
//    "iuu_class_class_id" = 1;
//    "iuu_sturdent_student_id" = "<null>";
//    "iuu_teacher_user_id" = "<null>";
//    "rongyu_content" = hahahaaaaaaaaaaaaaa;
//    "rongyu_id" = 14;
//    "rongyu_time" = "2016-03-28";
//},



    return mode;
}
@end
