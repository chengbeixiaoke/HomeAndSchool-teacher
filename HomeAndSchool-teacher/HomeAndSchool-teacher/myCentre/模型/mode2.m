//
//  mode2.m
//  JXTSU
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 LYF. All rights reserved.
//

#import "mode2.h"

@implementation mode2


+(instancetype)mode2WithDic:(NSDictionary *)dic{
    mode2 *mode = [[self alloc]init];
    [mode setValuesForKeysWithDictionary:dic];
    
    return mode;
}
@end
