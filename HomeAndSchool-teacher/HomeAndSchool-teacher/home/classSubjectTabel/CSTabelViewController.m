//
//  CSTabelViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "CSTabelViewController.h"
#import "Define.h"
#import "timeTabelservice.h"
#import "CSTabelCollectionViewCell.h"

@interface CSTabelViewController ()

@property (strong, nonatomic)NSMutableArray *items;

@property (assign, nonatomic)float lineHeight;

@property (strong, nonatomic)UILabel *lineLabel;

@property (strong, nonatomic)UITableView *table;

@property (strong, nonatomic)UIVisualEffectView *visualEffectView;

@property (assign, nonatomic)BOOL isShow;

@property (strong, nonatomic)NSArray *classArr;

@property (assign, nonatomic)NSInteger b;

@property (assign, nonatomic)int classid;

@property (assign, nonatomic)NSString *subject;

@property (copy, nonatomic)NSString *className;

@property (strong, nonatomic)UILabel *classNameLabel;

@end

@implementation CSTabelViewController

@synthesize items = _items;

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isShow = NO;
    self.b = 1;
    self.classid = 1;
    self.subject = @"语文";
    
    
    [self service];
    
    [self navigationHader];
    
    [self collection];
    
    [self RequestClass];
    
    [self classSelect];
}

- (void)service{
    
    [timeTabelservice timeTabelClass:_classid andSubject:@"语文" andSuccess:^(NSArray *timeTabelArr) {
        
        self.tabelArr = timeTabelArr;
        
        [self.myCollection reloadData];
        
    } andFail:^(NSString *fail) {
        
    }];
    
}

- (void)collection{
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    self.myCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, VIEW_WIDTH, VIEW_HEIGHT - 104) collectionViewLayout:flow];
    self.myCollection.delegate = self;
    self.myCollection.dataSource = self;
    self.myCollection.backgroundColor = [UIColor whiteColor];
    [self.myCollection registerClass:[CSTabelCollectionViewCell class] forCellWithReuseIdentifier:@"111"];
    self.myCollection.scrollEnabled = NO;
    self.myCollection.userInteractionEnabled = NO;
    [self.view addSubview:_myCollection];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 77;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CSTabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"111" forIndexPath:indexPath];
    
    NSArray *tmparr1 = @[@"",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];

    if (indexPath.row < 7) {
        
        cell.subjectLabel.text = tmparr1[indexPath.row];
    
    }else{
//        
//        if (![_tabelArr[indexPath.row - 7]isEqualToString:@""]) {
//           
//            cell.subjectLabel.backgroundColor = COLOR(46, 184, 245, 1);
//            
//        }else{
//            
//            cell.subjectLabel.backgroundColor = [UIColor whiteColor];
//            
//        }
    
        cell.subjectLabel.text = _tabelArr[indexPath.row - 7];

    }
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    float from = (VIEW_WIDTH * 3)/19;
//    NSLog(@"%f",from);
    int from_width = (int)from;
    int from_height = VIEW_WIDTH - 6 *from_width;
    self.lineHeight = from_height + 10 * from_width *3/4 -5;
    [self firstlab];
    if (indexPath.row < 7) {
        if (indexPath.row == 0) {
            return CGSizeMake(from_height, from_height);
        }else{
            return CGSizeMake(from_width, from_height);
        }
    }else{
        if (indexPath.row%7 == 0) {
            return CGSizeMake(from_height, from_width*3/4);
        }else{
            return CGSizeMake(from_width, from_width*3/4);
        }
    }
}

-(UILabel *)firstlab{
     //判断是否已经有了，若没有，则进行实例化
    if (!_lineLabel) {
        self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _lineHeight + 104, VIEW_WIDTH, 1)];
        self.lineLabel.backgroundColor = COLOR(46, 184, 245, 0.5);
        [self.view addSubview:_lineLabel];
    }
    return _lineLabel;
}

- (void)navigationHader{
    
    self.navigationItem.title = @"课程表";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(315, 10, 30, 20)];
    [nextBtn setTitle:@"班级" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [nextBtn addTarget:self action:@selector(next0) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:nextBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)leftButton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(315, 65, 0, 0)];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.scrollEnabled = NO;
    self.table.layer.cornerRadius = 10;
    self.table.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_table];
    
    self.classNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 69, 200, 30)];
    self.classNameLabel.text = @"一年级一班";
    self.classNameLabel.font = FONT(15);
    self.classNameLabel.textAlignment = NSTextAlignmentCenter;
    self.classNameLabel.textColor = COLOR(50, 50, 50, 1);
    [self.view addSubview:_classNameLabel];
}

//班级选择方法
- (void)next0{
    
    if (self.navigationItem.title) {
        
        if (_isShow == NO) {
            self.isShow = YES;
            self.visualEffectView.hidden = NO;
            [UIView animateWithDuration:0.2 animations:^{
                self.table.frame = CGRectMake(215, 65, 100, 20*_classArr.count);
            }];
            
        }else{
            self.isShow = NO;
            self.visualEffectView.hidden = YES;
            [UIView animateWithDuration:0.2 animations:^{
                self.table.frame = CGRectMake(315, 65, 0, 0);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _classArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self next0];
    self.classNameLabel.text = _classArr[indexPath.row];
    self.b = indexPath.row + 1;
    
//    [self service];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
