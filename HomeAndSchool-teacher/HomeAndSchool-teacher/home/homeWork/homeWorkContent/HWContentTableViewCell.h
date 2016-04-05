//
//  HWContentTableViewCell.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+tap.h"

@interface HWContentTableViewCell : UITableViewCell

@property (strong, nonatomic)UILabel *HWcontentLabel;

@property (strong, nonatomic)UIImageView_tap *HWContentImage;

@property (strong, nonatomic)UILabel *lineLabel;

@property (strong, nonatomic)UIImageView *bianqin;

@property (strong, nonatomic)NSMutableArray *imageArr;

@property (strong, nonatomic)UITapGestureRecognizer *tapGesture;

@end
