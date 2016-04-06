//
//  ClassMode.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassMode : NSObject

/** id */
@property (copy,nonatomic)NSString *class_id;

/** 班级名称 */
@property (copy,nonatomic)NSString *class_name;


+(instancetype)classModeWithDic:(NSDictionary *)dic;
@end
