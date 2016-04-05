//
//  ResultViewController.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol resultDelegate <NSObject>

- (void)navgationbarHidden;

@end


@interface ResultViewController : UIViewController<resultDelegate>

@property(strong,nonatomic)NSArray *userModel;

@property(strong,nonatomic)UISearchBar *search;

@property(strong,nonatomic)UITableView *MyTableView;

@end
