//
//  SUClassController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "SUClassController.h"
#import "Define.h"
#import "RYModel.h"
#import "HowClassMode.h"
#import "SUMeRYCell.h"
#import "sercice.h"
#import "AFNetworking.h"

@interface SUClassController ()<UITableViewDataSource,UITableViewDelegate>
/**  tab */
@property (strong,nonatomic)UITableView *myTab;

/**  模型数组 */
@property (strong,nonatomic)NSMutableArray *modesArr;
/**  模型数组 */
@property (strong,nonatomic)NSArray *classArr;


@end

@implementation SUClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modesArr = [NSMutableArray arrayWithCapacity:0];
    [self navgation];
    [self creatKongJian];
    [self requst];
    
    
}
//andHowClassMode:(HowClassMode*)howclassmode
-(void)classRongyuRequest:(int)classid andtitltSection:(NSString *)titltSection{
    
    
    
    NSString *str = @"http://localhost:8888/JXT/index.php/home/RongYu/classRongYu";
    NSString *url = [NSString stringWithFormat:@"%@?class_id=%d",str,classid];
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [sercice GETRequiceAFNetworkingWithURL:url parameters:nil successHUDTitle:nil faileHUDTitle:nil sendMessage:^(NSDictionary *responseObject) {
             if ([responseObject[@"error_code"] intValue]==200 ) {
            
            NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:0];
            NSArray *arrc = responseObject[@"result"];
            for (NSDictionary *dic1 in arrc) {
                
                RYModel *mode = [RYModel modeWithDic:dic1];
                [mutArr addObject:mode];
                
            }
                 [mutDic setObject:mutArr forKey:titltSection];
            
            [self.modesArr addObject:mutDic];
                 NSLog(@"classid====%d,self.modesArr====%@",classid,self.modesArr);
                 
        }else{
            NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:0];
            
            [mutDic setObject:mutArr forKey:titltSection];
            
            [self.modesArr addObject:mutDic];
        }
        

        [self.myTab reloadData];
        
        
    }];
    

    
}

-(void)requst{
    
    NSString *classURL =@"http://localhost:8888/JXT/index.php/home/Class/howClass?teacher_id=2";
    
    
          [sercice GETRequiceAFNetworkingWithURL:classURL parameters:nil successHUDTitle:@"加载中" faileHUDTitle:@"加载失败" sendMessage:^(NSDictionary *responseObject) {
              
              if ([responseObject[@"error_code"] intValue]==200) {
              NSArray *arr = responseObject[@"result"];
                  
              NSMutableArray *classArr = [NSMutableArray array];
                  
                  for (int i =0; i<arr.count; i++) {
                      NSDictionary *dic=arr[i];
                      
                      int classid = [dic[@"class_id"] intValue];
                      
                      
                      NSLog(@"classid----%d",classid);
                      
                      NSString *titltSection =dic[@"class_name"];
                      HowClassMode *mode = [HowClassMode howClassModeWithDic:dic];
                      [classArr addObject:mode];
                      [self classRongyuRequest:classid andtitltSection:titltSection];
                      
                  }
                  self.classArr = classArr;

                  
              }//if
     }];

    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.modesArr.count;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
//     HowClassMode *mode = self.classArr[section];
//        return mode.class_name;
    
    NSDictionary *dic = self.modesArr[section];
    NSArray *arr = [dic allKeys];
    NSString *str = arr[0];
    
    return str;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger i;
//    NSLog(@"self.modesArr----%@",self.modesArr);
//    NSArray *arr = self.modesArr[section];
    NSDictionary *dic = self.modesArr[section];
    NSArray *arr = [dic allKeys];
    NSString *str = arr[0];
    NSArray *arrr = [dic objectForKey:str];
    if (arrr==nil) {
        i=0;
    }else{
        i = arrr.count;
    }
    NSLog(@"section:%ld---i:%ld",(long)section,(long)i);
    return i;
}

#pragma mark - 取高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h;
    
    NSDictionary *dic = self.modesArr[indexPath.section];
    NSArray *arr = [dic allKeys];
    NSString *str = arr[0];
    NSArray *arrr = [dic objectForKey:str];
    
    if (arrr==nil) {
        h=0;
    }else{
        h=150;
    }
    return h;
}

#pragma mark - 建立cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SUMeRYCell *cell = [SUMeRYCell cellWithTableView:tableView];

    
    NSDictionary *dic = self.modesArr[indexPath.section];
    NSArray *arr = [dic allKeys];
    NSString *str = arr[0];
    NSArray *arrr = [dic objectForKey:str];
    cell.mode = arrr[indexPath.row];
    
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
    
    self.navigationItem.title = @"班级荣誉";
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.view.backgroundColor =COLOR(248, 248, 248, 1);
    
    
}


@end
