//
//  mode1.h
//  JXTSU
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 LYF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mode1 : NSObject
/** key */
@property (copy,nonatomic)NSString *name;
/** value */
@property (copy,nonatomic)NSString *valu;

+(instancetype)mode1WithDic:(NSDictionary *)dic;
@end
