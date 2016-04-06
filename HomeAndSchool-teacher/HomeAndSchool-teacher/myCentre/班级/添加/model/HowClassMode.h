//
//  HowClassMode.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
////    "error_code": "200",
//    "reason": "success!",
//    "result":
//    [
//     {
//         "how_id": "116",
//         "class_id": "2",
//         "class_name": "二年级一班",
//         "teacher_id": "2"
//     },
//     {
//         "how_id": "117",
//         "class_id": "1",
//         "class_name": "一年级一班",
//         "teacher_id": "2"
//     }
//     ]
//}

#import <Foundation/Foundation.h>

@interface HowClassMode : NSObject

/** id */
@property (copy,nonatomic)NSString *how_id;

/** teacher_id */
@property (copy,nonatomic)NSString *teacher_id;

/** 班级名称 */
@property (copy,nonatomic)NSString *class_name;

/** 班级名称 */
@property (copy,nonatomic)NSString *class_id;



+(instancetype)howClassModeWithDic:(NSDictionary *)dic;
@end
