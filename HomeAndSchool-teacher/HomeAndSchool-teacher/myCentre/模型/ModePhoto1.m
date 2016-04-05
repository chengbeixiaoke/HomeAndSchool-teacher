//
//  ModePhoto1.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "ModePhoto1.h"

@implementation ModePhoto1


+(instancetype)photoMode1Image:(UIImage *)image{
    
    ModePhoto1 *mode = [[self alloc]init];
    mode.image =image;
    return mode;
}
@end
