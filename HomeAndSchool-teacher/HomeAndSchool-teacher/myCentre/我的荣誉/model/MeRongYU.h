//
//  MeRongYU.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeRongYU : NSObject

/** rongyu_content */
@property (copy,nonatomic)NSString *rongyu_content;

/** ongyu_time */
@property (copy,nonatomic)NSString *yongyu_time;


//

+(instancetype)memodeWithDic:(NSDictionary *)dic;
@end
