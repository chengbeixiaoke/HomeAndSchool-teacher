//
//  UpdateCell.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "UpdateCell.h"
#import "Header.h"

@implementation UpdateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.label0 = [[UILabel alloc]init];
        self.label0.textColor = [UIColor blackColor];
        self.label0.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_label0];
        
        self.label1 = [[UILabel alloc]init];
        self.label1.font = [UIFont systemFontOfSize:15];
        self.label1.text = @"正常";
        [self.contentView addSubview:_label1];
        
        self.btn1 = [[UIButton alloc]init];
        self.btn1.layer.cornerRadius = 15;
        self.btn1.backgroundColor = COLOR(73, 189, 241);
        [self.btn1 setTitle:@"正常" forState:UIControlStateNormal];
        self.btn1.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btn1 setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_btn1];
        
        self.btn2 = [[UIButton alloc]init];
        self.btn2.layer.cornerRadius = 15;
        self.btn2.backgroundColor = [UIColor grayColor];
        [self.btn2 setTitle:@"迟到" forState:UIControlStateNormal];
        self.btn2.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btn2 setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_btn2];
        
        self.btn3 = [[UIButton alloc]init];
        self.btn3.layer.cornerRadius = 15;
        self.btn3.backgroundColor = [UIColor grayColor];
        [self.btn3 setTitle:@"缺勤" forState:UIControlStateNormal];
        self.btn3.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btn3 setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_btn3];
    }
    
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.label0.frame = CGRectMake(15, 15, 60, 20);
    self.label1.frame = CGRectMake(100, 15, 40, 20);
    self.btn1.frame = CGRectMake(175, 10, 30, 30);
    self.btn2.frame = CGRectMake(225, 10, 30, 30);
    self.btn3.frame = CGRectMake(275, 10, 30, 30);
    
}




@end
