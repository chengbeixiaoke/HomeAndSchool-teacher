//
//  timeTabelservice.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface timeTabelservice : NSObject

+ (void)timeTabelClass:(int)classid andSubject:(NSString *)subject andSuccess:(void(^)(NSArray *timeTabelArr))success andFail:(void(^)(NSString *fail))fail;

@end
