//
//  myCenterViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "myCenterViewController.h"
#import "PhotoTableViewCell.h"
#import "me2TableViewCell.h"
#import "me3TableViewCell.h"
#import "mode1.h"
#import "mode2.h"
#import "Define.h"
#import "MePhotoViewController.h"
#import "ModePhoto1.h"

@interface myCenterViewController ()<UITableViewDataSource,UITableViewDelegate>

/**  tableview*/
@property (strong,nonatomic)UITableView *myTab;
/** 头像模型 */
@property (copy,nonatomic)ModePhoto1 *modePhoto1;

/**  模型属猪 2/3*/
@property (strong,nonatomic)NSArray *modes;
@property (strong,nonatomic)NSArray *modes2;


@end

@implementation myCenterViewController

//读取本地信息
-(UIImage *)duQuDocumentImage{
    
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [paths firstObject];
    
    NSString *imagePath = [document stringByAppendingPathComponent:@"image"];
    
    NSString *image = [imagePath stringByAppendingPathComponent:@"image.png"];
    
    UIImage *images = [UIImage imageWithContentsOfFile:image];
    
    return images;
}

#pragma mark - 头像模型
-(ModePhoto1 *)modePhoto1{
    //读取本地文件
    UIImage *images = [self duQuDocumentImage];
    if (images) {
        _modePhoto1 = [ModePhoto1 photoMode1Image:images];
        
    }else{
        _modePhoto1 = [ModePhoto1 photoMode1Image:[UIImage imageNamed:@"wo.png"]];
        
    }
    return _modePhoto1;
}


-(NSArray *)modes{
    if (_modes==nil) {
        
        NSDictionary *dic = @{
                              @"账号":@"11111111",
                              @"学校":@"名扬高中",
                              @"班级":@"终极一班"
                              };
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
        NSArray *arr = [dic allKeys];
        
        for (int i = 0; i<arr.count; i++) {
            NSDictionary *dic2 = @{arr[i]:dic[arr[i]]};
            mode1 *mode = [mode1 mode1WithDic:dic2];
            [arr1 addObject:mode];
        }
        
        self.modes =arr1;
    }
    return _modes;
}
-(NSArray *)modes2{
    
    if (_modes2==nil) {
        NSDictionary *dic = @{
                              @"value":@[
                                      
                                      @{
                                          @"image":@"班级荣誉.png",
                                          @"name":@"班级荣誉"
                                          },
                                      @{    @"image":@"我的荣誉.png",
                                            @"name":@"我的荣誉"
                                            },
                                      @{
                                          @"image":@"设置.png",
                                          @"name":@"设置"
                                          }
                                      
                                      ]
                              };
        NSMutableArray *arr2 = [NSMutableArray array];
        
        NSArray *arr = dic[@"value"];
        
        for (NSDictionary *dic2 in arr) {
            
            mode2 *mode = [mode2 mode2WithDic:dic2];
            [arr2 addObject:mode];
        }
        
        self.modes2 = arr2;
    }
    
    return _modes2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.navigationItem.title = @"我的";
    self.navigationController.navigationBar.translucent = NO;
    [self creatTableVier];
    
}

#pragma mark - 回来时刷新头像

-(void)viewWillAppear:(BOOL)animated{
    
    [self.myTab reloadData];
  
}

#pragma mark - 创建table
-(void)creatTableVier{
    CGFloat w=self.view.frame.size.width;
    CGFloat h=self.view.frame.size.height;
    self.myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, w, h) style:UITableViewStylePlain];
    self.myTab.backgroundColor = [UIColor clearColor];
    self.myTab.delegate = self;
    self.myTab.dataSource = self;
    [self.view addSubview:_myTab];
    self.myTab.tableFooterView = [[UIView alloc]init];
    self.myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTab.scrollEnabled = NO;
    
    
}

#pragma mark - 选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0&&indexPath.row==0) {
        MePhotoViewController *photo =[[MePhotoViewController alloc]init];
        photo.hidesBottomBarWhenPushed  = YES;//隐藏tabbar
        
        [self.navigationController pushViewController:photo animated:YES];
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 18;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger H;
    if (indexPath.section==0) {
        
        if (indexPath.row ==0) {
            H = 78;
        }else{
            H = 44;
        }
    }else{
        H=44;
    }
    return H;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 4;
    }else{
        return 3;
    }
    
    
}

-(UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat w=self.view.frame.size.width;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 18)];
    
    view.backgroundColor = self.view.backgroundColor;
    return view;
}

#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            PhotoTableViewCell *cell = [PhotoTableViewCell cellWithTab:tableView IndexPath:indexPath];
            cell.mode = self.modePhoto1;
            
           return cell;
            
        }else{
            
            me2TableViewCell *cell = [me2TableViewCell cellWithTab:tableView IndexPath:indexPath];
            cell.mode =self.modes[indexPath.row-1];
            return cell;
        }
        
    }else{
        
        me3TableViewCell *cell = [me3TableViewCell cellWithTab:tableView IndexPath:indexPath];
        cell.mode = self.modes2[indexPath.row];
        return cell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
