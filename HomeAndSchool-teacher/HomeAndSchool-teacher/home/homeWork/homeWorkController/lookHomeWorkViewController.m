//
//  lookHomeWorkViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "lookHomeWorkViewController.h"
#import "Define.h"
#import "homeWorkTableViewCell.h"
#import "YCXMenu.h"
#import "homeWorkService.h"
#import "HWContentViewController.h"
#import "setHWViewController.h"

@interface lookHomeWorkViewController ()

@property (strong, nonatomic) NSMutableArray *items;

@property (assign, nonatomic)int classId;

@property (strong, nonatomic)UITableView *table;

@property (strong, nonatomic)UIVisualEffectView *visualEffectView;

@property (assign, nonatomic)BOOL isShow;

@property (strong, nonatomic)NSArray *classArr;

@property (assign, nonatomic)NSInteger b;

@property (assign, nonatomic)int classid;

@property (assign, nonatomic)NSString *subject;

@property (copy, nonatomic)NSString *className;

@property (strong, nonatomic)UIButton *chooseClassBut;

@end

@implementation lookHomeWorkViewController

@synthesize items = _items;

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.classId = 1;
    
    self.view.backgroundColor = COLOR(249, 249, 249, 1);
    
    [self navigationHader];
    
    [self chooseClass];
    
    [self service];
    
    [self makeTable];
    
    [self RequestClass];
    
    [self classSelect];
    
}

- (void)service{
    
    [homeWorkService requestHomeWork:@"语文" andWithClass:_classId andWithSuccess:^(NSArray *contentArr) {
        
        self.homeWorkData = contentArr;
        
        [self.lookHomeWorkTable reloadData];
        
    } andWithFail:^(NSString *str) {
        
    }];
}

- (void)navigationHader{
    
    self.navigationItem.title = @"作业板";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 16, 16)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)leftButton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightButton{

    setHWViewController *setHWVc = [[setHWViewController alloc]init];
    setHWVc.delegate = self;
    [self.navigationController pushViewController:setHWVc animated:YES];
    
    
}

- (void)chooseClass{
    
    self.chooseClassBut = [[UIButton alloc]initWithFrame:CGRectMake(80, 74, 160, 30)];
    [self.chooseClassBut setTitle:@"一年级(1)班" forState:UIControlStateNormal];
    self.chooseClassBut.titleLabel.font = FONT(15);
    [self.chooseClassBut setTintColor:[UIColor whiteColor]];
    self.chooseClassBut.backgroundColor = COLOR(84, 190, 240, 1);
    self.chooseClassBut.layer.cornerRadius = 5;
    [self.view addSubview:_chooseClassBut];
    [self.chooseClassBut addTarget:self action:@selector(next0) forControlEvents:UIControlEventTouchDown];
    
    UIButton *imageBut = [[UIButton alloc]initWithFrame:CGRectMake(210, 74, 30, 30)];
    [imageBut setImage:[UIImage imageNamed:@"butImage"] forState:UIControlStateNormal];
    [self.view addSubview:imageBut];
    [imageBut addTarget:self action:@selector(next0) forControlEvents:UIControlEventTouchDown];
    
}

- (void)RequestClass{
    
    //    NSDictionary *dic = @{@"teacher":@"1"};
    
    //    [KaoqinService class0:dic andSuccess:^(NSArray *arr) {
    //
    //        if (arr.count > 0) {
    //
    //            self.classArr = arr;
    //            self.navigationItem.title = _classArr[0];
    //        }else{
    //            self.navigationItem.title = @"无班级";
    //        }
    //    }];
    
    self.classArr = @[@"一年级一班",@"二年级一班",@"三年级一班"];
    
    self.className = @"一年级一班";
}

//班级选择
- (void)classSelect{
    
    self.visualEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    self.visualEffectView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    self.visualEffectView.alpha = 0.3;
    self.visualEffectView.hidden = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(next0)];
    [self.visualEffectView addGestureRecognizer:recognizer];
    [self.view addSubview:_visualEffectView];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(80, 104, 0, 0)];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.scrollEnabled = NO;
    self.table.layer.cornerRadius = 10;
    self.table.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_table];
    
}
//班级选择方法
- (void)next0{
    
    if (self.navigationItem.title) {
        
        if (_isShow == NO) {
            self.isShow = YES;
            self.visualEffectView.hidden = NO;
            [UIView animateWithDuration:0.2 animations:^{
                self.table.frame = CGRectMake(80, 104, 160, 20*_classArr.count);
            }];
            
        }else{
            self.isShow = NO;
            self.visualEffectView.hidden = YES;
            [UIView animateWithDuration:0.2 animations:^{
                self.table.frame = CGRectMake(80, 104, 0, 0);
            }];
        }
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查网络！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)makeTable{
    
    self.lookHomeWorkTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 110, VIEW_WIDTH, VIEW_HEIGHT-110)];
    
    self.lookHomeWorkTable.delegate = self;
    self.lookHomeWorkTable.dataSource = self;
    self.lookHomeWorkTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.lookHomeWorkTable.showsVerticalScrollIndicator = YES;
    self.lookHomeWorkTable.backgroundColor = COLOR(249, 249, 249, 1);
    [self.view addSubview:_lookHomeWorkTable];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == _lookHomeWorkTable) {
        return self.homeWorkData.count;
    }else{
        return _classArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _lookHomeWorkTable) {
        return 120;
    }else{
        return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _lookHomeWorkTable) {
        static NSString *ssstr = @"cell";
        
        homeWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ssstr];
        
        if (cell == nil) {
            
            cell = [[homeWorkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ssstr];
            
        }
        cell.backgroundColor = COLOR(249, 249, 249, 1);
        
        cell.timeLabel.text = [_homeWorkData[indexPath.row] objectForKey:@"time"];
        cell.contentLabel.text = [_homeWorkData[indexPath.row] objectForKey:@"content"][0];
        return cell;

    }else{
        static NSString *str = @"123";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        
        cell.textLabel.text = _classArr[indexPath.row];
        cell.textLabel.textAlignment = 1;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _lookHomeWorkTable) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        HWContentViewController *ContentVc = [[HWContentViewController alloc]init];
        
        ContentVc.content = _homeWorkData[indexPath.row];
        
        [self.navigationController pushViewController:ContentVc animated:YES];
    }else{
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self next0];
        [self.chooseClassBut setTitle:_classArr[indexPath.row] forState:UIControlStateNormal];
        self.b = indexPath.row + 1;
      //[self service];
    }
}

- (void)reload{
    
    [self service];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
