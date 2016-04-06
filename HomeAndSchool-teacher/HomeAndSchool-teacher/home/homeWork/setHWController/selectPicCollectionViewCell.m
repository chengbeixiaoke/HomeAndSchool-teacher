//
//  selectPicCollectionViewCell.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "selectPicCollectionViewCell.h"

@implementation selectPicCollectionViewCell

- (void)awakeFromNib {
    NSLog(@"%s",__FUNCTION__);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.MyImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.MyImageView];
        
        self.selectedImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.selectedImageView];
    }
    return self;
}

@end
