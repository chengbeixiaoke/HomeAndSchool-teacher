//
//  me2TableViewCell.m
//  JXT
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 LYF. All rights reserved.
//

#import "me2TableViewCell.h"
#import "mode1.h"
#import "Define.h"
#define WWIETHX(x)   [UIScreen mainScreen].bounds.size.width*x/320

@interface me2TableViewCell ()
@property (strong , nonatomic) IBOutlet UILabel *nameLab;


@property (strong, nonatomic) IBOutlet UILabel *valuLab;
/**  线 */
@property (strong,nonatomic)UIView *line;


@end
@implementation me2TableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.nameLab = [[UILabel alloc]init];
        self.nameLab.font =[UIFont systemFontOfSize:15];
        
        self.valuLab = [[UILabel alloc]init];
        self.valuLab.font =[UIFont systemFontOfSize:12];
        self.valuLab.textColor = COLOR(85, 85, 85, 1);
        
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.valuLab];
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = COLOR(223,223 , 223, 1);
        [self.contentView addSubview:self.line];
        
        
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat h = self.contentView.frame.size.height;
    
    self.nameLab.frame = CGRectMake(WWIETHX(15), (h-18)/2, WWIETHX(100), 18) ;
    self.valuLab.frame =CGRectMake(WWIETHX(230), (h-18)/2, WWIETHX(100), WWIETHX(18));
    self.line .frame = CGRectMake(WWIETHX(15), h-1, WWIETHX(320-15), 1);
    
}

-(void)setMode:(mode1 *)mode{
    _mode = mode;
    self.nameLab.text = mode.name;
    self.valuLab.text = mode.valu;
}

+(instancetype)cellWithTab:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell2";
    me2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    if (cell==nil) {
        cell = [[me2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row==3) {
        cell.accessoryType = UITableViewCellSeparatorStyleSingleLine;
        [cell layoutIfNeeded];
        
        
    }else{
     
        cell.accessoryType = 0;

    }
 
    
    cell.selectionStyle = 0;
    return cell;
    
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
}

@end
