//
//  homeWorkService.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface homeWorkService : NSObject


+ (void)requestHomeWork:(NSString *)subject andWithClass:(int)classId andWithSuccess:(void (^)(NSArray *contentArr))success andWithFail:(void (^)(NSString *str))fail;

+ (void)setHomeWorkSubject:(NSString *)subject andWithClass:(int)classId andTeacherId:(int)teacherId andHWContent:(NSString *)hwContent andTime:(NSString *)time andWithSuccess:(void (^)(NSString *))success andWithFail:(void (^)(NSString *))fail;

+ (void)setImg:(NSArray *)imgs andHomeWorkId:(int)homeWorkId andSubject:(NSString *)sub andSuccess:(void(^)(NSString *str))success andFail:(void(^)(NSString *str2))fail;


@end
