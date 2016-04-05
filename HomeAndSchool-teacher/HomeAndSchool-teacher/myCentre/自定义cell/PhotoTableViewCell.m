//
//  PhotoTableViewCell.m
//  JXT
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 LYF. All rights reserved.
//

#import "PhotoTableViewCell.h"
#import "Define.h"
#import "ModePhoto1.h"
#define WWIETHX(x)   [UIScreen mainScreen].bounds.size.width*x/320
@interface PhotoTableViewCell ()

/**  头像图片 */
@property (strong,nonatomic)UIImageView *touImg;

/**  头像lab */
@property (strong,nonatomic)UILabel *lab;

/**  线 */
@property (strong,nonatomic)UIView *line;

//@property (weak, nonatomic) IBOutlet UIImageView *touxiangImg;
@end


@implementation PhotoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.lab = [[UILabel alloc]init];
        self.lab.font =[UIFont systemFontOfSize:15];
        self.lab.text = @"头像";
        self.touImg = [[UIImageView alloc]init];
        self.touImg.image = [UIImage imageNamed:@"wo.png"];
        [self.contentView addSubview:self.lab];
        [self.contentView addSubview:self.touImg];
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = COLOR(223,223 , 223, 1);
        [self.contentView addSubview:self.line];

        
    }
    
    return self;
}
-(void)setMode:(ModePhoto1 *)mode{
    _mode = mode;
    
    self.touImg.image = mode.image;
    
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat h = self.contentView.frame.size.height;
    
    self.lab.frame = CGRectMake(WWIETHX(15), (h-18)/2, WWIETHX(100), 18) ;
    self.touImg.frame =CGRectMake(WWIETHX(224), (h-60)/2, 60, 60);
    self.line .frame = CGRectMake(WWIETHX(15), h-1, WWIETHX(320-15), 1);
    
}

+(instancetype)cellWithTab:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath{
   
           static NSString *ID = @"haha";
            PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            
            if (cell==nil) {
                cell = [[PhotoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
    
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
            return cell;
    
}

- (void)awakeFromNib {
   
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
