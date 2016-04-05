//
//  UIImageView+tap.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView_tap : UIImageView

//创建手势对象
@property (strong, nonatomic)UITapGestureRecognizer *tapGest;

@property (assign, nonatomic)BOOL isYesOrNo;

@property (strong, nonatomic)UIImageView *immg;

@end
