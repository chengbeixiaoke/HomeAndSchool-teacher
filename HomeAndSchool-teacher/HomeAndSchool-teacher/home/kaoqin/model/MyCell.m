//
//  MyCell.m
//  view-01
//
//  Created by administrator on 16/3/10.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.label = [[UILabel alloc]init];
        
        self.label.textAlignment = 1;
        
        self.label.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_label];
    }
    
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.frame = self.bounds;
        
}

@end
