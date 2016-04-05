//
//  MyTableViewCell.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyTableViewCell.h"


@implementation MyTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if (self) {
        
        
        self.UserPic=[[UIImageView alloc]init];
        
        [self.contentView addSubview:_UserPic];
        
        self.UserName=[[UILabel alloc]init];
        
        [self.contentView addSubview:_UserName];
        
        
    }
    
    return self;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    self.UserPic.frame=CGRectMake(15, 11, 46, 46);
    
    self.UserName.frame=CGRectMake(80, 15, self.frame.size.width, 15);
    
    self.UserName.font=[UIFont systemFontOfSize:15.0];
    
    }



@end
