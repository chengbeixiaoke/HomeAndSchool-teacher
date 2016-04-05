//
//  mode2.h
//  JXTSU
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 LYF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mode2 : NSObject

/** 图片 */
@property (copy,nonatomic)NSString *image;

/** name */
@property (copy,nonatomic)NSString *name;

+(instancetype)mode2WithDic:(NSDictionary *)dic;
@end
