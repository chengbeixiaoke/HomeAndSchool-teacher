//
//  ViewController.m
//  考勤-01
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "KaoqinViewController.h"
#import "MyCell.h"
#import "Header.h"
#import "YCXMenu.h"
#import "DetailViewController.h"
#import "UpdateViewController.h"
#import "KaoqinService.h"

@interface KaoqinViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UICollectionView *collection;

@property (strong,nonatomic) UITableView *table;

@property (assign,nonatomic) BOOL isShow;

@property (strong,nonatomic) UIVisualEffectView *visualEffectView;

@property (strong,nonatomic) NSArray *classArr;

@property (strong,nonatomic) UILabel *dateLabel;

@property (strong,nonatomic) NSDate *todayDate;

@property (strong,nonatomic) NSDate *changeDate;

@property (strong,nonatomic) NSArray *dateArr;

@property (strong,nonatomic) NSMutableArray *items;

@property (strong,nonatomic) NSMutableArray *changeColor;

@property (assign,nonatomic) int a;

@property (assign,nonatomic) NSInteger b;

@end

@implementation KaoqinViewController
@synthesize items = _items;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.a = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isShow = NO;
    
    self.b = 1;
    
    [self creatView];
    [self creatNavigation];
    [self RequestService:self.todayDate];
    [self RequestClass];
    [self classSelect];
    
}

- (void)RequestService:(NSDate *)date{
    
    self.changeColor = [NSMutableArray arrayWithCapacity:0];
    
    NSInteger b = [self day:date];
    NSString *str = [self yearMonth:date];
    
    for (int i = 0; i < b; i++) {
        NSDictionary *dic = @{
                              @"class":[NSString stringWithFormat:@"%ld",_b],
                              @"time":[NSString stringWithFormat:@"%@%02d",str,i+1]
                              };
        [KaoqinService kaoqin0:dic andSuccess:^(NSArray *arr) {
            
            if (arr.count > 0) {
                
                [self.changeColor addObject:[NSString stringWithFormat:@"%d",i]];
            }
            [self.collection reloadData];
        }];
    }
}

- (void)RequestClass{
    
        NSDictionary *dic = @{@"teacher":@"1"};
        
        [KaoqinService class0:dic andSuccess:^(NSArray *arr) {
            
            if (arr.count > 0) {
                
                self.classArr = arr;
                self.navigationItem.title = _classArr[0];
            }else{
                self.navigationItem.title = @"无班级";
            }
        }];
}

//班级选择
- (void)classSelect{
    
    self.visualEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    self.visualEffectView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
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

}


//自定义顶部导航按键
- (void)creatNavigation{
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 15)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back0) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(315, 10, 30, 20)];
    [nextBtn setTitle:@"班级" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [nextBtn addTarget:self action:@selector(next0) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:nextBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
}

//返回上一个界面方法
- (void)back0{
    
    [self.navigationController popViewControllerAnimated:YES];
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

//创建主视图
- (void)creatView{
    
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 74, WIDTH-40, 20)];
    self.dateLabel.textAlignment = 1;
    self.dateLabel.textColor = [UIColor blackColor];
    self.dateLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_dateLabel];
    
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 104+WIDTH+10, WIDTH-40, 30)];
    nextBtn.layer.cornerRadius = 5;
    [nextBtn setTitle:@"更新考勤" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextBtn setBackgroundColor:COLOR(73, 189, 241)];
    [nextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [nextBtn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    self.changeDate = [NSDate date];
    self.todayDate = _changeDate;
    [self creatDateLabel:_todayDate];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setItemSize:CGSizeMake(self.view.frame.size.width/7, self.view.frame.size.width/7)];
    
    //系统默认左右值为10
    [flowLayout setMinimumInteritemSpacing:0.0];
    [flowLayout setMinimumLineSpacing:0.0];
    
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 104, WIDTH, WIDTH) collectionViewLayout:flowLayout];
    
    self.collection.backgroundColor = [UIColor whiteColor];
    //    self.collection.showsVerticalScrollIndicator = NO;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
    //自定义cell
    [self.collection registerClass:[MyCell class] forCellWithReuseIdentifier:@"001"];
    [self.view addSubview:_collection];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 104+WIDTH+50, WIDTH-30, 50)];
    tipLabel.text = @"温馨提示：日历颜色黄色为有缺勤或者迟到问题，白色为全勤，点击有颜色的日期可以查看详情！";
    tipLabel.textAlignment = 1;
    tipLabel.numberOfLines = 0;
    tipLabel.textColor = [UIColor redColor];
    tipLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:tipLabel];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(next)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(last)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rightSwipe];

}

- (void)nextPage{
    
    UpdateViewController *uvc = [[UpdateViewController alloc]init];
    [self.navigationController pushViewController:uvc animated:YES];
    
}

//日历翻页（上个月）
- (void)last{
    
    if (_a == 0) {
        [UIView transitionWithView:_collection duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            self.changeDate = [self lastMonth:_changeDate];
            [self creatDateLabel:_changeDate];
            [self RequestService:_changeDate];
            self.a += 1;
        } completion:nil];
    }
}

//日历翻页（下个月）
- (void)next{
    
    if (_a == 1) {
        [UIView transitionWithView:_collection duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            self.changeDate = [self nextMonth:_todayDate];
            [self creatDateLabel:_changeDate];
            [self RequestService:_changeDate];
            self.a -= 1;
        } completion:nil];
    }
}

//上个月按钮的方法
- (NSDate *)lastMonth:(NSDate *)date{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    
    dateComponents.month = -1;
    
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    
    [self.collection reloadData];
    
    return newDate;
}


//下个月按钮的方法
- (NSDate *)nextMonth:(NSDate *)date{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    
//    dateComponents.month = +1;
    
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    
    [self.collection reloadData];
    
    return newDate;
    
}


//当天年月日
- (void)creatDateLabel:(NSDate *)date{
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay ) fromDate:_changeDate];
    
    NSString *label0 = [NSString stringWithFormat:@"%ld年%02ld月%02ld日",dateComponents.year,dateComponents.month,dateComponents.day];
    
    self.dateLabel.text = label0;
}


- (NSString *)yearMonth:(NSDate *)date{
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay) fromDate:_changeDate];
    
    NSString *str = [NSString stringWithFormat:@"%ld-%02ld-",dateComponents.year,dateComponents.month];
    
    return str;
    
}

//当天日期
- (NSInteger)day:(NSDate *)date{
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay) fromDate:_changeDate];
    
    return dateComponents.day;
    
}

//当月的第一天
- (NSInteger)firstDayInMonth:(NSDate *)date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay) fromDate:date];
    
    [comp setDay:1];
    
    NSDate *firstDay = [calendar dateFromComponents:comp];
    
    NSInteger firstDayInMonth = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDay];
    
    return firstDayInMonth - 1;
    
    
}

//当月的天数
- (NSInteger)numOfDaysInMonth:(NSDate *)date{
    
    NSRange days = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return days.length;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 7;
    }else{
        return 42;
    }
    
}

//******08
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"001";
    
    NSArray *weakArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    MyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        cell.layer.cornerRadius = 0;
        [cell.label setTextColor:[UIColor blackColor]];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.layer.cornerRadius = 0;
        cell.label.text = weakArr[indexPath.row];
        if (indexPath.row == 0 || indexPath.row == 6) {
            cell.label.textColor = [UIColor redColor];
        }
        
        return cell;
    }else{
        
       
        
        NSInteger numDays = [self numOfDaysInMonth:_changeDate];
        NSInteger firstDay0 = [self firstDayInMonth:_changeDate];
        
        if (indexPath.row < firstDay0) {
            
            cell.label.text = @"";
            [cell.label setTextColor:[UIColor blackColor]];
            cell.backgroundColor = [UIColor whiteColor];
            
        }else if (indexPath.row > firstDay0 + numDays -1){
            
            cell.label.text = @"";
            [cell.label setTextColor:[UIColor blackColor]];
            cell.backgroundColor = [UIColor whiteColor];
            
        }else{
            
            cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.row - firstDay0 +1];
            [cell.label setTextColor:[UIColor blackColor]];
            cell.backgroundColor = [UIColor whiteColor];
            //            cell.layer.cornerRadius = 320/14;
            
            if ([_todayDate isEqualToDate:_changeDate]) {
                if (indexPath.row - firstDay0 +1 == [self day:_changeDate]) {
                    [cell.label setTextColor:COLOR(73, 189, 241)];
//                    cell.backgroundColor = [UIColor greenColor];
                }else if (indexPath.row - firstDay0 +1 > [self day:_changeDate]){
                    [cell.label setTextColor:[UIColor grayColor]];
                }
            }else if ([_todayDate compare:_changeDate] == NSOrderedAscending){
                [cell.label setTextColor:[UIColor grayColor]];
            }
        }
        
        for (NSString *str in _changeColor) {
            if (indexPath.row == str.intValue+firstDay0) {
                cell.backgroundColor = [UIColor orangeColor];
            }else{
                cell.backgroundColor = [UIColor whiteColor];
            }
        }
        
        cell.layer.cornerRadius = WIDTH/14;
        return cell;
    }
    
    //    cell.backgroundColor = [UIColor whiteColor];
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return NO;
    }else{
        
        NSInteger numDays = [self numOfDaysInMonth:_changeDate];
        NSInteger firstDay0 = [self firstDayInMonth:_changeDate];
        
        if (indexPath.row <= firstDay0 + numDays -1 && indexPath.row >= firstDay0){
            
            if ([_changeDate isEqualToDate:_todayDate]) {
                if (indexPath.row <= [self day:_changeDate]+1) {
                    return YES;
                }
            }else if ([_todayDate compare:_changeDate] == NSOrderedDescending){
                return YES;
            }
        
        }
        
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger firstDay0 = [self firstDayInMonth:_changeDate];
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_changeDate];
    
    NSLog(@"%ld-%02ld-%02ld",comp.year,comp.month,indexPath.row - firstDay0 + 1);
    
    if (self.navigationItem.title) {
        
        MyCell *cell = (MyCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        if (cell.backgroundColor == [UIColor orangeColor]) {
            NSArray *arr = @[[NSString stringWithFormat:@"%ld",_b],[NSString stringWithFormat:@"%ld-%02ld-%02ld",comp.year,comp.month,indexPath.row - firstDay0 + 1],self.navigationItem.title];
            
            DetailViewController *dvc = [[DetailViewController alloc]init];
            
            dvc.arr0 = arr;
            
            [self.navigationController pushViewController:dvc animated:YES];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"班级表现良好，全勤！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
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
    self.navigationItem.title = _classArr[indexPath.row];
    self.b = indexPath.row + 1;
    
    [self RequestService:_changeDate];
}

//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    if (cell.backgroundColor == [UIColor whiteColor]) {
//        
//        cell.backgroundColor = [UIColor orangeColor];
//    }else if (cell.backgroundColor == [UIColor orangeColor]){
//        cell.backgroundColor = [UIColor whiteColor];
//    }
//}
//
//
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    
//    if (cell.backgroundColor == [UIColor orangeColor]) {
//        
//        [UIView animateWithDuration:0.5 animations:^{
//            cell.backgroundColor = [UIColor whiteColor];
//        }];
//    }
//    
//}

@end
