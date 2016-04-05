//
//  DetailViewController.m
//  考勤-01
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "DetailViewController.h"
#import "Header.h"
#import "DetailCell.h"


@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *table;

@property (copy,nonatomic) NSString *str1;

@property (copy,nonatomic) NSString *str2;

@property (strong,nonatomic) NSMutableArray *leaveArr;

@property (strong,nonatomic) NSMutableArray *skipArr;

@property (strong,nonatomic) NSMutableArray *lateArr;

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self RequestService];
    [self creatView];
    [self creatNavigation];
}

- (void)RequestService{
    
    
    
}

- (void)creatNavigation{
    
    self.navigationItem.title = _arr0[2];
    
//    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 15)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back0) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)back0{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatView{
    
    self.table =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellEditingStyleNone;
    self.table.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_table];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 2;
    }else{
        return 2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 30;
    }else{
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *arr = @[self.arr0[1],@"",@"",@""];
    
    UIView *view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    view0.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *label10 = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, WIDTH, 20)];
    label10.text = arr[section];
    label10.font = [UIFont systemFontOfSize:15];
    label10.textColor = COLOR(73, 189, 241);
    label10.textAlignment = 1;
    [view0 addSubview:label10];
    
    return view0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str1 = @"001";
    static NSString *str2 = @"002";
    static NSString *str3 = @"003";
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DetailCell *cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
            cell.label0.text = @"班级人数：  47";
            cell.selectionStyle = NO;
            return cell;
        }else{
            DetailCell *cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
            cell.label0.text = @"实到人数：  47";
            cell.selectionStyle = NO;
            return cell;
            
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            DetailCell *cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str2];
            cell.label0.text = @"请假人员：";
            cell.label1.text = @"王哈哈  请假时间：  一天";
            cell.selectionStyle = NO;
            return cell;
        }else{
            DetailCell *cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str2];
            cell.label0.hidden = YES;
            cell.label1.text = @"王哈哈  请假时间：  一天";
            cell.selectionStyle = NO;
            return cell;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            DetailCell *cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str3];
            cell.label0.text = @"缺勤人员：";
            cell.label1.text = @"王哈哈";
            cell.selectionStyle = NO;
            return cell;
        }else{
            DetailCell *cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str3];
            cell.label0.hidden = YES;
            cell.label1.text = @"王哈哈";
            cell.selectionStyle = NO;
            return cell;
        }

    }else{
        if (indexPath.row == 0) {
            DetailCell *cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str3];
            cell.label0.text = @"迟到人员：";
            cell.label1.text = @"王哈哈";
            cell.selectionStyle = NO;
            return cell;
        }else{
            DetailCell *cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str3];
            cell.label0.hidden = YES;
            cell.label1.text = @"王哈哈";
            cell.selectionStyle = NO;
            return cell;
        }

    }
    
}

@end
