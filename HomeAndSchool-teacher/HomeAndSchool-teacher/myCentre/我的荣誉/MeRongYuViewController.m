//
//  MeRongYuViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MeRongYuViewController.h"
#import "Define.h"
#import "MeRongYU.h"
#import "SUMeRYCell.h"
#import "sercice.h"
@interface MeRongYuViewController ()<UITableViewDataSource,UITableViewDelegate>
/**  tab */
@property (strong,nonatomic)UITableView *myTab;

/**  模型数组 */
@property (strong,nonatomic)NSArray *modesArr;


@end

@implementation MeRongYuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navgation];
    [self creatKongJian];
    [self requst];
    
    
}

-(void)requst{
    
    
    NSMutableArray *mutArr = [NSMutableArray array];
    
    [sercice POSTRequiceAFNetworkingWithURL:@"http://localhost:8888/JXT/index.php/home/RongYu/meRongYu?teacherid=2" parameters:nil successHUDTitle:nil faileHUDTitle:nil sendMessage:^(NSDictionary *responseObject) {
        NSArray *arr = responseObject[@"result"];
        for (NSDictionary *dic in arr) {
            MeRongYU *mode = [MeRongYU memodeWithDic:dic];
            [mutArr addObject:mode];
        }
        
        self.modesArr = mutArr;
        [self.myTab reloadData];
        
    }];
    
 
    
}


#pragma mark - 预计高度
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.modesArr.count;
}

#pragma mark - 取高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    RYModel *mode = self.modesArr[indexPath.row];
    
    return 150;
}

#pragma mark - 建立cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SUMeRYCell *cell = [SUMeRYCell cellWithTableView:tableView];
    cell.meMode = self.modesArr[indexPath.row];
    
    return cell;
}
#pragma mark - 建立控件
-(void)creatKongJian{
    
    self.myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,VIEW_WIDTH , VIEW_HEIGHT) style:UITableViewStylePlain];
    self.myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTab.showsHorizontalScrollIndicator = NO;
    self.myTab.delegate = self;
    self.myTab.dataSource = self;
    
    self.myTab.tableFooterView = [[UIView alloc]init];
    
    
    [self.view addSubview:_myTab];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - 左侧按钮
-(void)leftButton{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - navgation

-(void)navgation{
    
    self.navigationItem.title = @"我的荣誉";
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.view.backgroundColor =COLOR(248, 248, 248, 1);
    
    
}


@end
