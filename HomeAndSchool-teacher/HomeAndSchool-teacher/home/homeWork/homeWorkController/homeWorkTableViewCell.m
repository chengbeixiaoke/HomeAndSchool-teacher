//
//  homeWorkTableViewCell.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "homeWorkTableViewCell.h"
#import "Define.h"

@implementation homeWorkTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.homeWorkBakImage = [[UIImageView alloc]init];
        self.homeWorkBakImage.image = [UIImage imageNamed:@"homeworkBak"];
        [self.contentView addSubview:_homeWorkBakImage];
        
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.text = @"1、P24页第三题。";
        self.contentLabel.font = FONT(15);
        self.contentLabel.textColor = COLOR(50, 50, 50, 1);
        [self.contentView addSubview:_contentLabel];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.text = @"3月4号";
        self.timeLabel.font = FONT(12);
        self.timeLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_timeLabel];
        
        self.advanceImg= [[UIImageView alloc]init];
        self.advanceImg.image = [UIImage imageNamed:@"advance"];
        [self.contentView addSubview:_advanceImg];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.homeWorkBakImage.frame = CGRectMake(5, 5, CELL_WIDTH-10, 110);
    
    self.contentLabel.frame = CGRectMake(20, 67, 200, 15);
    
    self.timeLabel.frame = CGRectMake(30, 28, 100, 15);
    
    self.advanceImg.frame = CGRectMake(290, 40, 10, 20);
    
}

@end
