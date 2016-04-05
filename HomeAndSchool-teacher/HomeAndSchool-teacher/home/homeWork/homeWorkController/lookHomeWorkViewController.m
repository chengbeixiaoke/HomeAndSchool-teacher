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
    
    UIButton *chooseClass = [[UIButton alloc]initWithFrame:CGRectMake(80, 74, 160, 30)];
    [chooseClass setTitle:@"一年级(1)班" forState:UIControlStateNormal];
    chooseClass.titleLabel.font = FONT(15);
    [chooseClass setTintColor:[UIColor whiteColor]];
    chooseClass.backgroundColor = COLOR(84, 190, 240, 1);
    chooseClass.layer.cornerRadius = 5;
    [self.view addSubview:chooseClass];
    [chooseClass addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchDown];
    
    UIButton *imageBut = [[UIButton alloc]initWithFrame:CGRectMake(210, 74, 30, 30)];
    [imageBut setImage:[UIImage imageNamed:@"butImage"] forState:UIControlStateNormal];
    [self.view addSubview:imageBut];
    [imageBut addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchDown];
    
}

- (void)choose:(UIButton *)sender{
    
    [YCXMenu setTintColor:COLOR(84, 190, 240, 1)];
    [YCXMenu showMenuInView:self.view fromRect:CGRectMake(80, 104, 160, 0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
        
        NSString *str = item.title;
        [sender setTitle:str forState:UIControlStateNormal];
        
        self.classId = 2;
        
        [self service];
        
    }];
}

- (NSMutableArray *)items{
    
    if (!_items) {
        
        YCXMenuItem *menuTitle = [YCXMenuItem menuTitle:@"班级" WithIcon:nil];
        menuTitle.foreColor = [UIColor whiteColor];
        menuTitle.titleFont = FONT(15);
        
        _items = [@[menuTitle,
                    [YCXMenuItem menuItem:@"二年级1班"
                                    image:nil
                                      tag:5000
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@"四年级1班"
                                    image:nil
                                      tag:5001
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@"五年级1班"
                                    image:nil
                                      tag:5002
                                 userInfo:@{@"title":@"Menu"}],
                    ] mutableCopy];
    }
    return _items;
}

- (void)setItems:(NSMutableArray *)items {
    _items = items;
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
    
    return self.homeWorkData.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ssstr = @"cell";
    
    homeWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ssstr];
    
    if (cell == nil) {
        
        cell = [[homeWorkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ssstr];
        
    }
    cell.backgroundColor = COLOR(249, 249, 249, 1);
    
    cell.timeLabel.text = [_homeWorkData[indexPath.row] objectForKey:@"time"];
    cell.contentLabel.text = [_homeWorkData[indexPath.row] objectForKey:@"content"][0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HWContentViewController *ContentVc = [[HWContentViewController alloc]init];
    
    ContentVc.content = _homeWorkData[indexPath.row];
    
    [self.navigationController pushViewController:ContentVc animated:YES];
    
}

- (void)reload{
    
    [self service];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
