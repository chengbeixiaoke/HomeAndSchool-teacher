//
//  UpdateViewController.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate>

@property (strong,nonatomic) UITableView *table;

@property (strong,nonatomic) UISearchController *searchC;

@property (strong,nonatomic) NSArray *arr0;

@property (strong,nonatomic) NSArray *arr1;

@property (strong,nonatomic) NSArray *arr2;

@property (strong,nonatomic) NSMutableArray *mutArr00;

@property (strong,nonatomic) NSMutableArray *mutArr0;

@property (strong,nonatomic) NSMutableArray *mutArr1;

@property (strong,nonatomic) NSMutableArray *mutArr2;

@property (strong,nonatomic) NSMutableArray *mutArr3;

@property (strong,nonatomic) NSMutableArray *mutArr4;



@end
