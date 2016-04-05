//
//  CSTabelCollectionViewCell.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "CSTabelCollectionViewCell.h"
#import "Define.h"

@implementation CSTabelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.subjectLabel = [[UILabel alloc]init];
        self.subjectLabel.font = FONT(12);
        self.subjectLabel.textAlignment = NSTextAlignmentCenter;
        self.subjectLabel.layer.borderColor = COLOR(46, 184, 245, 0.5).CGColor;
        self.subjectLabel.layer.borderWidth = 0.5;
        self.subjectLabel.textColor = COLOR(150, 150, 150, 1);
        [self.contentView addSubview:_subjectLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
     self.subjectLabel.frame = self.contentView.frame;
    
}
@end
