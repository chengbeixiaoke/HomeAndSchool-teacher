//
//  ClassTableViewCell.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "ClassTableViewCell.h"
#import "ClassMode.h"
#import "HowClassMode.h"
#import "Define.h"
@interface ClassTableViewCell ()
/**  课程 */
@property (strong,nonatomic)UILabel *classLab;

/**  线 */
@property (strong,nonatomic)UIView *line;
@end
@implementation ClassTableViewCell

-(void)setClassMode:(ClassMode *)classMode{
    
    _classMode = classMode;
    
    self.classLab.text = classMode.class_name;
    
    
}

-(void)setHowClassMode:(HowClassMode *)howClassMode{
    _howClassMode = howClassMode;
    self.classLab.text = howClassMode.class_name;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.classLab = [[UILabel alloc]init];
        
        self.classLab.font = [UIFont systemFontOfSize:15];
        
        self.classLab.textColor = [UIColor darkGrayColor];
        
        [self.contentView addSubview:self.classLab];
        
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = COLOR(223,223 , 223, 1);
        [self.contentView addSubview:self.line];

    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat h = self.contentView.frame.size.height;
    CGFloat w = self.contentView.frame.size.width;
    self.classLab.frame = CGRectMake(15, 10, w-30, h-20);
    self.line.frame =CGRectMake(0, h-1, w+100, 1);
   
  }


+(instancetype)cellWithTab:(UITableView *)tableView{
    
    static NSString *ID = @"cell";
    ClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    if (cell==nil) {
        cell = [[ClassTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
        return cell;
    
}


@end
