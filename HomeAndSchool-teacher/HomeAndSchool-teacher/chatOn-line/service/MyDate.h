//
//  MyDate.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDate : NSObject

+ (void)Register:(NSString *)userId andSuccess:(void (^)(NSString *token))success;


+ (void)CreatGroup:(NSDictionary *)groupInfo  andSuccess:(void (^)(NSString *tips))success;




@end




