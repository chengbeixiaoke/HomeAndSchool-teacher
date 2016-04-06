//
//  RYModel.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/1.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYModel : NSObject
//    "iuu_class_class_id" = 1;
//    "iuu_sturdent_student_id" = "<null>";
//    "iuu_teacher_user_id" = "<null>";
//    "rongyu_content" = hahahaaaaaaaaaaaaaa;
//    "rongyu_id" = 14;
//    "rongyu_time" = "2016-03-28";
//},

/**  班级id */
@property (assign,nonatomic)int classid;
/** rongyu_content */
@property (copy,nonatomic)NSString *rongyu_content;

/** ongyu_time */
@property (copy,nonatomic)NSString *yongyu_time;

///**  cell高 */
//@property (assign,nonatomic) CGFloat heightCell;
//

+(instancetype)modeWithDic:(NSDictionary *)dic;
@end
