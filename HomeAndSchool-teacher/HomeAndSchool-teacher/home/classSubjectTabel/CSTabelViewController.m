//
//  CSTabelViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "CSTabelViewController.h"
#import "Define.h"
#import "YCXMenu.h"
#import "timeTabelservice.h"
#import "CSTabelCollectionViewCell.h"

@interface CSTabelViewController ()

@property (strong, nonatomic) NSMutableArray *items;

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
    
    [self service];
    
    [self navigationHader];
    
    [self chooseClass];
    
    [self collection];
}

- (void)service{
    
    [timeTabelservice timeTabelClass:1 andSubject:@"语文" andSuccess:^(NSArray *timeTabelArr) {
        
        self.tabelArr = timeTabelArr;
        NSLog(@"%@",_tabelArr);
        
    } andFail:^(NSString *fail) {
        
    }];
    
}

- (void)collection{
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    self.myCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 104, VIEW_WIDTH, VIEW_HEIGHT - 104) collectionViewLayout:flow];
    self.myCollection.delegate = self;
    self.myCollection.dataSource = self;
    self.myCollection.showsVerticalScrollIndicator = NO;
    self.myCollection.backgroundColor = [UIColor whiteColor];
    [self.myCollection registerClass:[CSTabelCollectionViewCell class] forCellWithReuseIdentifier:@"111"];
    self.myCollection.scrollEnabled = NO;
    [self.view addSubview:_myCollection];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 77;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CSTabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"111" forIndexPath:indexPath];
    
    //        {
    //            code = 200;
    //            data =     (
    //                        {
    //                            "iuu_class_class_id" = 1;
    //                            "timetable_eight" = "\U82f1\U8bed";
    //                            "timetable_five" = "\U82f1\U8bed";
    //                            "timetable_four" = "\U8bed\U6587";
    //                            "timetable_id" = 1;
    //                            "timetable_one" = "\U8bed\U6587";
    //                            "timetable_seven" = "\U8bed\U6587";
    //                            "timetable_six" = "\U6570\U5b66";
    //                            "timetable_three" = "\U6570\U5b66";
    //                            "timetable_two" = "\U82f1\U8bed";
    //                            "timetable_week" = 1;
    //                        },

    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    float from = (VIEW_WIDTH * 3)/19;
//    NSLog(@"%f",from);
    int from_width = (int)from;
    int from_height = VIEW_WIDTH - 6 *from_width;
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, from_height + 10 * from_width *3/4 -5, VIEW_WIDTH, 1)];
    lineLabel.backgroundColor = COLOR(46, 184, 245, 0.5);
    [self.myCollection addSubview:lineLabel];
    
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

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.backgroundColor == [UIColor whiteColor]) {
        
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }else if(cell.backgroundColor == [UIColor groupTableViewBackgroundColor]){
        
        cell.backgroundColor = [UIColor whiteColor];
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.backgroundColor == [UIColor groupTableViewBackgroundColor]) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            cell.backgroundColor = [UIColor whiteColor];
            
        }];
        
    }
}
- (void)navigationHader{
    
    self.navigationItem.title = @"课程表";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
//
//    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 16, 16)];
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightButton) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)leftButton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//- (void)rightButton{
//
//    
//}

- (void)chooseClass{
    
    UIButton *chooseClass = [[UIButton alloc]initWithFrame:CGRectMake(80, 69, 160, 30)];
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
        
//        self.classId = 2;
        
//        [self service];
        
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
