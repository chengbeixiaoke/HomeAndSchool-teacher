//
//  setHWTableViewCell.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "setHWTableViewCell.h"
#import "Define.h"

@implementation setHWTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.HWcontentLabel = [[UILabel alloc]init];
        self.HWcontentLabel.font = FONT(15);
        self.HWcontentLabel.numberOfLines = 0;
        [self.contentView addSubview:_HWcontentLabel];
        
        self.lineLabel = [[UILabel alloc]init];
        self.lineLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_lineLabel];
        
        self.advanceImg= [[UIImageView alloc]init];
        self.advanceImg.image = [UIImage imageNamed:@"advance"];
        [self.contentView addSubview:_advanceImg];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize contentViewSize = self.contentView.frame.size;
        
    self.HWcontentLabel.frame = CGRectMake(10, 5, CELL_WIDTH-25,contentViewSize.height - 10);
    self.lineLabel.frame = CGRectMake(0, contentViewSize.height-0.5, contentViewSize.width, 0.5);
    
    self.advanceImg.frame = CGRectMake(CELL_WIDTH - 15, contentViewSize.height/2 - 10, 10, 20);
}

@end
