//
//  HWContentViewController.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWContentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)NSDictionary *content;

@property (strong, nonatomic)UITableView *HWContentTable;

- (UIImage *)cutImage:(UIImage*)image andCGSize:(CGSize)size;

@end
