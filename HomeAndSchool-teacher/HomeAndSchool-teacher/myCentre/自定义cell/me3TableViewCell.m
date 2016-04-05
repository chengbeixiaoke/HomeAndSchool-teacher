//
//  me3TableViewCell.m
//  JXTSU
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 LYF. All rights reserved.
//

#import "me3TableViewCell.h"
#import "mode2.h"
#import "Define.h"
#define WWIETHX(x)   [UIScreen mainScreen].bounds.size.width*x/320
@interface me3TableViewCell ()
@property (strong , nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
/**  线 */
@property (strong,nonatomic)UIView *line;



@end
@implementation me3TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.nameLab = [[UILabel alloc]init];
        self.nameLab.font =[UIFont systemFontOfSize:15];
        self.nameLab.text = @"头像";
        self.img = [[UIImageView alloc]init];
        self.img.image = [UIImage imageNamed:@"wo.png"];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.img];
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = COLOR(223,223 , 223, 1);
        [self.contentView addSubview:self.line];
        
        
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat h = self.contentView.frame.size.height;
    
    self.nameLab.frame = CGRectMake(WWIETHX(52), (h-18)/2, WWIETHX(100), 18) ;
    self.img.frame =CGRectMake(WWIETHX(15), (h-WWIETHX(20))/2, WWIETHX(20), WWIETHX(20));
    self.line .frame = CGRectMake(WWIETHX(15), h-1, WWIETHX(320-15), 1);
    
}


-(void)setMode:(mode2 *)mode{
    _mode = mode;
    self.img.image = [UIImage imageNamed:mode.image];
    self.nameLab.text = mode.name;
}


+(instancetype)cellWithTab:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"touxiang";
    me3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        cell = [[me3TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID] ;
    }
    cell.selectionStyle = 0;
    cell.img.image = [UIImage imageNamed:@"wo.png"];
    cell.nameLab.text = @"班级荣誉";
    cell.accessoryType = 1;
    
    return cell;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
