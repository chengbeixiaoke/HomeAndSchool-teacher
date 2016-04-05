//
//  homeCollectionViewCell.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "homeCollectionViewCell.h"
#import "Define.h"

@implementation homeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.picMark = [[UIImageView alloc]init];
        [self.contentView addSubview:_picMark];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = FONT(12);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = COLOR(150, 150, 150, 1);
        [self.contentView addSubview:_titleLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.picMark.frame = CGRectMake(40, 20, 35, 35);
    self.titleLabel.frame = CGRectMake(15, 60, 80, 20);
    
}
@end
