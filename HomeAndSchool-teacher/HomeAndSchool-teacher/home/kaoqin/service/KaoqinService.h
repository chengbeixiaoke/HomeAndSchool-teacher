//
//  KaoqinService.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KaoqinService : NSObject

+ (void)kaoqin0:(NSDictionary *)dic andSuccess:(void(^)(NSArray *arr))success;

+ (void)class0:(NSDictionary *)dic andSuccess:(void(^)(NSArray *arr))success;

+ (void)studentNum:(NSDictionary *)dic andSuccess:(void(^)(NSString *str))success;

+ (void)leaveStudent:(NSDictionary *)dic andSuccess:(void(^)(NSArray *arr))success;

@end
