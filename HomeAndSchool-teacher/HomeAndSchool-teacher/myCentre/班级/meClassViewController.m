//
//  meClassViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "meClassViewController.h"
#import "Define.h"
#import "HowClassMode.h"
#import "sercice.h"
#import "AddClassViewController.h"
#import "ClassTableViewCell.h"
@interface meClassViewController ()<UITableViewDataSource,UITableViewDelegate>
/**  添加按钮 */
//@property (strong,nonatomic)UIButton *addBtn;
/**  tabview */
@property (strong,nonatomic)UITableView *myTab;
/**  模型数组 */
@property (strong,nonatomic)NSMutableArray *modeArr;

/**  编辑模式 */
@property (assign,nonatomic)UITableViewCellEditingStyle type;



/**  是否编辑 */
@property (assign,nonatomic,getter=isEdite)BOOL edite;

@end

@implementation meClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edite = 0;
    self.type = UITableViewCellEditingStyleNone;
    [self navgation];
    
    [self creatKongJian];
    [self qingqiuShuJu];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self qingqiuShuJu];
}

#pragma mark - 请求网络数据
-(void)qingqiuShuJu{

//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    
//    parameters[@"teacher_id"]=@(2);
//    
    NSString *url =@"http://localhost:8888/JXT/index.php/home/Class/howClass?teacher_id=2";
    
//    NSString *str = [NSString stringWithFormat:@"%@?teacher_id=%d",url,2];


    [sercice GETRequiceAFNetworkingWithURL:url parameters:nil successHUDTitle:@"加载中" faileHUDTitle:@"加载失败" sendMessage:^(NSDictionary *responseObject) {
       
       
        NSLog(@"====%d",[responseObject[@"error_code"] intValue]);
        if ([responseObject[@"error_code"] intValue]==200) {
             NSArray *arr = responseObject[@"result"];
            NSMutableArray *mytArr = [NSMutableArray array];
            
            for (NSDictionary *dic in arr) {
                HowClassMode *mode = [HowClassMode howClassModeWithDic:dic];
                [mytArr addObject:mode];
            }
            
            self.modeArr = mytArr;
            [self.myTab reloadData];

        }else{
            NSLog(@"班级为空");
        }
        
        
    }];
    
}


#pragma mark - 右侧按钮



#pragma mark - 编辑模式
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HowClassMode *mode = self.modeArr[indexPath.row];
    
  
    
    NSString *str =@"http://localhost:8888/JXT/index.php/home/Class/delectedClass";
    NSString *url = [NSString stringWithFormat:@"%@?how_id=%d",str,[mode.how_id intValue]];
    
    [sercice GETRequiceAFNetworkingWithURL:url parameters:nil successHUDTitle:@"删除中~" faileHUDTitle:@"删除失败" sendMessage:^(NSDictionary *responseObject) {
       
        if ([responseObject[@"error_code"] intValue]==200) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");

        }
        [self.modeArr removeObjectAtIndex:indexPath.row];
        [self.myTab reloadData];
    }];
    
   }


#pragma mark - 选中某行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.modeArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    ClassTableViewCell *cell = [ClassTableViewCell cellWithTab:tableView];
    
     HowClassMode *mode =self.modeArr[indexPath.row];
    
    cell.howClassMode =mode;
    
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



#pragma mark - 左侧按钮
-(void)leftButton{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}
#pragma mark - navgation

-(void)navgation{
    
    self.navigationItem.title = @"我的班级";
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.view.backgroundColor =COLOR(248, 248, 248, 1);
    
    
   
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 16, 16)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightbton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
#pragma mark - 添加按钮
-(void)rightbton{
    
    
    AddClassViewController *addClass = [[AddClassViewController alloc]init];
    
    addClass.ID = @"4";
    
    [self.navigationController pushViewController:addClass animated:YES];
    
    
    
}

@end
