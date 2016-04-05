//
//  ModePhoto1.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ModePhoto1 : NSObject


/** 头像 */
@property (strong ,nonatomic)UIImage *image;

+(instancetype)photoMode1Image:(UIImage *)image;
@end
