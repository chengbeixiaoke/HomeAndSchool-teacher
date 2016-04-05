//
//  lookHomeWorkViewController.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol reloadDataDelegate <NSObject>

- (void)reload;

@end

@interface lookHomeWorkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,reloadDataDelegate>

@property (strong, nonatomic)UITableView *lookHomeWorkTable;

@property (strong, nonatomic)NSArray *homeWorkData;

@end
