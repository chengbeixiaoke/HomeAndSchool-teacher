//
//  AddClassViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "AddClassViewController.h"
#import "Define.h"
#import "sercice.h"
#import "ClassMode.h"
//#import "SVProgressHUD.h"
#import "ClassTableViewCell.h"

@interface AddClassViewController ()<UITableViewDataSource,UITableViewDelegate>

/**  mytab */
@property (strong,nonatomic)UITableView *myTab;
/**  模型数组 */
//@property (strong,nonatomic)NSArray *modeArr;
//@property (strong,nonatomic)NSArray *sectionArr;

/** st */
@property (copy,nonatomic)NSString *error_code;
/**   */
@property (strong,nonatomic)NSMutableDictionary *showdic;


@end

@implementation AddClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navgation];
    [self creatKongJian];
    [self qingqiuShuJu];
    
    
}

#pragma mark - 请求网络数据
-(void)qingqiuShuJu{
    
    NSString *str =@"http://localhost:8888/JXT/index.php/home/Class/jiaZaiClass";
   [sercice GETRequiceAFNetworkingWithURL:str parameters:nil successHUDTitle:@"加载中" faileHUDTitle:@"加载失败" sendMessage:^(NSDictionary *responseObject) {
        NSArray *arr = responseObject[@"result"];
       NSMutableDictionary *showdic = [NSMutableDictionary dictionaryWithCapacity:0];
               /**
                *  读取数据（分组）
                */
      
               for (NSDictionary *dic in arr) {
       
       
                   NSString *str = dic[@"class_name"];
                   NSString *section = [str substringToIndex:3];
                   ClassMode *mode = [ClassMode classModeWithDic:dic];
                   if (![[showdic allKeys] containsObject:section]) {
       
                        NSMutableArray *mutArr = [NSMutableArray array];
                       [mutArr addObject:mode];
                       [showdic setObject:mutArr forKey:section];
       
                   }else{
       
                       [showdic[section] addObject:mode];
                   }
                   
       
               }
               self.showdic = showdic;
            
               
               [self.myTab reloadData];
   }];

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
  
    return [_showdic allKeys].count;
}



#pragma mark - 选中某行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //抢取数据，因为字典无顺序，故不能直接利用section和row来取
    NSString *sectionStr = [self sectionTitle:indexPath.section];
    NSArray *sectionArr = [_showdic objectForKey:sectionStr];
    
    ClassMode *mode =sectionArr[indexPath.row];
    
    NSString *str = @"http://localhost:8888/JXT/index.php/home/Class/addClass";
    NSLog(@"%d",[mode.class_id intValue]);
  
    NSString *url = [NSString stringWithFormat:@"%@?class_id=%d&teacher_id=%d",str,[mode.class_id intValue],2];
    
    

    #pragma mark - 网络请求
    [sercice GETRequiceAFNetworkingWithURL:url parameters:nil successHUDTitle:nil faileHUDTitle:nil sendMessage:^(NSDictionary *responseObject) {
       
        id error_code =responseObject[@"error_code"];
        if ([error_code intValue]==400) {
            NSLog(@"已纯在");
        }else if ([error_code intValue]==200){
            NSLog(@"添加成功");
        }else if ([error_code intValue]==500){
            NSLog(@"添加失败");

        }

    }];

  }

-(NSString *)sectionTitle:(NSInteger)section{
    
    NSString *sectionStr;
    
    switch (section) {
        case 0:
            sectionStr = @"一年级";
            break;
        case 1:
            sectionStr = @"二年级";
            break;
            
        case 2:
            sectionStr = @"三年级";
            break;
            
        case 3:
            sectionStr = @"四年级";
            break;
            
        case 4:
            sectionStr = @"五年级";
            break;
            
        case 5:
            sectionStr = @"六年级";
            break;
            
            
        default:
            break;
    }
    
    return sectionStr;
}



#pragma mark - cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    ClassTableViewCell *cell = [ClassTableViewCell cellWithTab:tableView];
    
    NSString *str = [self sectionTitle:indexPath.section];
    NSArray *sectionArr = [_showdic objectForKey:str];
    
    ClassMode *mode =sectionArr[indexPath.row];
    cell.classMode = mode;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = [_showdic allKeys];
    
    //某组
    
    NSArray *sectionArr = [_showdic objectForKey:arr[section]];
    
    return sectionArr.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *str = [self sectionTitle:section];
 
    return str;
}


#pragma mark - 建立控件
-(void)creatKongJian{
    
    self.myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,VIEW_WIDTH , self.view.frame.size.height) style:UITableViewStylePlain];
    self.myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTab.showsVerticalScrollIndicator = NO;
    self.myTab.delegate = self;
    self.myTab.dataSource = self;
    
    [self.view addSubview:_myTab];
    
}
#pragma mark - navgation

-(void)navgation{
    
    self.navigationItem.title = @"添加班级";
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.view.backgroundColor =COLOR(248, 248, 248, 1);
    
    
}

#pragma mark - 左侧按钮
-(void)leftButton{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  



}


@end
