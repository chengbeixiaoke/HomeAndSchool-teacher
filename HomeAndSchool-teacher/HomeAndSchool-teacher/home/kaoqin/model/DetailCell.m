//
//  DetailCell.m
//  考勤-01
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "DetailCell.h"
#import "Header.h"

@implementation DetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if ([reuseIdentifier isEqualToString:@"001"]) {
            
            self.label0 = [[UILabel alloc]init];
            self.label0.textColor = [UIColor grayColor];
            self.label0.font = [UIFont systemFontOfSize:15];
            [self.contentView addSubview:_label0];
            
        }else if ([reuseIdentifier isEqualToString:@"002"]){
            
            self.label0 = [[UILabel alloc]init];
            self.label0.textColor = [UIColor grayColor];
            self.label0.font = [UIFont systemFontOfSize:15];
            [self.contentView addSubview:_label0];
            
            self.label1 = [[UILabel alloc]init];
            self.label1.textColor = [UIColor grayColor];
            self.label1.font = [UIFont systemFontOfSize:15];
            [self.contentView addSubview:_label1];
            
        }else if ([reuseIdentifier isEqualToString:@"003"]){
            
            self.label0 = [[UILabel alloc]init];
            self.label0.textColor = [UIColor grayColor];
            self.label0.font = [UIFont systemFontOfSize:15];
            [self.contentView addSubview:_label0];
            
            self.label1 = [[UILabel alloc]init];
            self.label1.textColor = [UIColor grayColor];
            self.label1.font = [UIFont systemFontOfSize:15];
            [self.contentView addSubview:_label1];
            
            self.view0 = [[UIView alloc]init];
            self.view0.backgroundColor = COLOR(73, 189, 241);
            self.view0.layer.cornerRadius = 5;
            [self.contentView addSubview:_view0];
            
            self.label2 = [[UILabel alloc]init];
            self.label2.textColor = [UIColor whiteColor];
            self.label2.text = @"联系家长";
            self.label2.textAlignment = 1;
            self.label2.font = [UIFont systemFontOfSize:12];
            [self.view0 addSubview:_label2];
            
        }
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if ([self.reuseIdentifier isEqualToString:@"001"]) {
        
        self.label0.frame = CGRectMake(15, 5, 200, 20);
        
    }else if ([self.reuseIdentifier isEqualToString:@"002"]){
        
        self.label0.frame = CGRectMake(15, 5, 100, 20);
        self.label1.frame = CGRectMake(125, 5, 180, 20);
        
    }else if ([self.reuseIdentifier isEqualToString:@"003"]){
        
        self.label0.frame = CGRectMake(15, 5, 100, 20);
        self.label1.frame = CGRectMake(125, 5, 100, 20);
        self.view0.frame = CGRectMake(self.frame.size.width-75, 5, 60, 20);
        self.label2.frame = CGRectMake(0, 0, 60, 20);
        
    }
}

@end
