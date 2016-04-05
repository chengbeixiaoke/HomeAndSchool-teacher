//
//  UIImageView+tap.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "UIImageView+tap.h"

@implementation UIImageView_tap

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.isYesOrNo = YES;
        
        self.immg = [[UIImageView alloc]init];
        self.immg.frame = self.frame;
        
        //初始化点击手势
        self.tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGest:)];
        
        //设置点击次数，触发事件
        self.tapGest.numberOfTapsRequired = 1;
        //设置一根手指
        self.tapGest.numberOfTouchesRequired = 1;
        //改变imageview不能交互的默认状态为可以交互
        self.userInteractionEnabled = YES;
        //添加到myimage上
        [self addGestureRecognizer:self.tapGest];
        
    }
    return self;
}

////点击手势所触发的事件
- (void)tapGest:(UITapGestureRecognizer *)longgest{

//    NSLog(@"666");

}


@end
