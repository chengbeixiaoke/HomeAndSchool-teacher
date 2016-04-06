//
//  SUMeRYCell.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/1.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "SUMeRYCell.h"
#import "RYModel.h"
#import "MeRongYU.h"
#import "Define.h"
#define WWIETHX(x)   [UIScreen mainScreen].bounds.size.width*(x)/320

@interface SUMeRYCell ()
@property (strong, nonatomic)  UILabel *yueLab;
@property (strong, nonatomic)  UILabel *DayLab;
@property (strong, nonatomic)  UIImageView *bgImg;
@property (strong, nonatomic)  UILabel *contentLab;

@property (strong, nonatomic)  UIView *quan;
/**  分割线 */
@property (strong, nonatomic) UIView *line;

@end

@implementation SUMeRYCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"rongyu";
    SUMeRYCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SUMeRYCell alloc]initWithStyle:0 reuseIdentifier:ID];
        
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.yueLab = [[UILabel alloc]init];
        self.DayLab = [[UILabel alloc]init];
        self.yueLab.textAlignment =NSTextAlignmentLeft;
        self.DayLab.textAlignment = NSTextAlignmentRight;
        self.yueLab.font = [UIFont systemFontOfSize:15];
        self.DayLab.font = [UIFont systemFontOfSize:13];
        self.yueLab.textColor = COLOR(135, 135, 135, 1);
        self.DayLab.textColor = COLOR(135, 135, 135, 1);
        
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor =COLOR(135, 135, 135, 1);
        
        self.quan = [[UIView alloc]init];
        self.quan.backgroundColor =COLOR(135, 135, 135, 1);
        
        
        self.bgImg = [[UIImageView alloc]init];
        self.bgImg.image = [UIImage imageNamed:@"u=2070269357,1957453008&fm=21&gp=0.jpg"];
        self.contentLab = [[UILabel alloc]init];
//        self.contentLab.textAlignment = NSTextAlignmentCenter;
        self.contentLab.numberOfLines = 0;
        
        
        [self.contentView addSubview:_yueLab];
        [self.contentView addSubview:_DayLab];
        
        [self.contentView addSubview:_line];
        
        [self.contentView addSubview:_quan];
        
        [self.contentView addSubview:_bgImg];
        
        [self.contentView addSubview:_contentLab];
        
        
    }
    return self;

}



-(void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat h = self.contentView.frame.size.height;
 
    
    self.yueLab.frame = CGRectMake(WWIETHX(10), 20, WWIETHX(40), 20);
    
    self.DayLab.frame = CGRectMake(WWIETHX(10), 40, WWIETHX(40), 20);
    
    self.line.frame = CGRectMake(WWIETHX(70), 0, WWIETHX(1), h);
    self.quan.frame = CGRectMake(WWIETHX(70-5), (h-WWIETHX(10))/2, WWIETHX(10),WWIETHX(10));
    self.quan.layer.cornerRadius = self.quan.frame.size.width/2;
    self.bgImg.frame= CGRectMake(WWIETHX(85), 10, WWIETHX(320-10-85), h-20);
    
    self.contentLab.frame = CGRectMake(WWIETHX(105), 20, WWIETHX(320-10-125), h-40);
    self.contentLab.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
    
}
-(void)setMode:(RYModel *)mode{
    _mode = mode;
    NSString *str = mode.yongyu_time;
    
    /** 截取字符串用（关键字）*/
    NSArray* stringArray = [str componentsSeparatedByString: @"-"];
    NSString  *mouthString = [stringArray objectAtIndex:1];
    NSString* dayString = [stringArray objectAtIndex: 2];
    self.yueLab.text = mouthString;
    self.DayLab.text = dayString;
    
    self.contentLab.text = mode.rongyu_content;
    
    
   
       
}
-(void)setMeMode:(MeRongYU *)meMode{
    
    _meMode = meMode;
    NSString *str = meMode.yongyu_time;
    
    /** 截取字符串用（关键字）*/
    NSArray* stringArray = [str componentsSeparatedByString: @"-"];
    NSString  *mouthString = [stringArray objectAtIndex:1];
    NSString* dayString = [stringArray objectAtIndex: 2];
    self.yueLab.text = mouthString;
    self.DayLab.text = dayString;
    
    self.contentLab.text = meMode.rongyu_content;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
    
}

@end
