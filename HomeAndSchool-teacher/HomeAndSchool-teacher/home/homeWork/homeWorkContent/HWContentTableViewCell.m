//
//  HWContentTableViewCell.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "HWContentTableViewCell.h"
#import "Define.h"

@implementation HWContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        if ([reuseIdentifier isEqualToString: @"cell1"]) {
            
            self.HWcontentLabel = [[UILabel alloc]init];
            self.HWcontentLabel.font = FONT(15);
            self.HWcontentLabel.numberOfLines = 0;
            [self.contentView addSubview:_HWcontentLabel];
            
            self.lineLabel = [[UILabel alloc]init];
            self.lineLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self.contentView addSubview:_lineLabel];
            
        }else if([reuseIdentifier isEqualToString:@"cell2"]){
            
            self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enlarge:)];
            self.tapGesture.numberOfTapsRequired = 1;
            self.tapGesture.numberOfTouchesRequired = 1;
            
            self.imageArr = [NSMutableArray arrayWithCapacity:0];
            
            for (int i = 0; i < 9; i++) {
                self.HWContentImage = [[UIImageView_tap alloc]init];
                self.HWContentImage.userInteractionEnabled = YES;
                [self.HWContentImage addGestureRecognizer:_tapGesture];
                [_imageArr addObject:_HWContentImage];
                [self.contentView addSubview:_HWContentImage];
            }
        }
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize contentViewSize = self.contentView.frame.size;
    
    if ([self.reuseIdentifier isEqualToString:@"cell1"]) {
        
        self.HWcontentLabel.frame = CGRectMake(10, 5, CELL_WIDTH-10,contentViewSize.height - 20);
        self.lineLabel.frame = CGRectMake(0, contentViewSize.height-0.5, contentViewSize.width, 0.5);
        
    }else if ([self.reuseIdentifier isEqualToString:@"cell2"]){
        
        for (int i = 0; i < _imageArr.count; i++) {
            
            int j = i/3+0.7;
            int k = 0;
            if (j == 0) {
                k=0;
            }else if (j == 1){
                k=3;
            }else if (j == 2){
                k = 6;
            }
            
            self.HWContentImage = _imageArr[i];
            self.HWContentImage.frame = CGRectMake(5 + ((contentViewSize.width - 20)/3 + 5)*(i-k), 5 + ((contentViewSize.width - 20)/3 + 5)*j, 100, 100);
        }
        [_imageArr removeAllObjects];
    }
}

- (void)enlarge:(UITapGestureRecognizer *)tapGesture{
    
    //    if (_isYesOrNo) {
    //
    //    }else{
    //
    //
    //    }
    
    NSLog(@"我是图片");
    
}

@end
