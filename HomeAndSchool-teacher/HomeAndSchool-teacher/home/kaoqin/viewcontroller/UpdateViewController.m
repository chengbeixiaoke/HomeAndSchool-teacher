//
//  UpdateViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "UpdateViewController.h"
#import "UpdateCell.h"
#import "Header.h"
@interface UpdateViewController ()

@property (strong,nonatomic) UIView *view00;

@property (strong,nonatomic) UILabel *label2;

@property (strong,nonatomic) UILabel *label3;

@end

@implementation UpdateViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mutArr00 = [NSMutableArray arrayWithCapacity:0];
    self.mutArr0 = [NSMutableArray arrayWithCapacity:0];
    
    [self creatView];
    [self creatNavigation];
    [self creatBottomView];
    
}

- (void)creatNavigation{
    
     self.navigationItem.title = @"记录考勤";
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 15)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back0) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(315, 10, 30, 20)];
    [nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [nextBtn addTarget:self action:@selector(next0) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:nextBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

- (void)back0{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)next0{
    
}

- (void)creatView{
    
    //    self.arr0 = [NSMutableArray arrayWithCapacity:0];
    //
    //    for (char a = 'A'; a <= 'Z'; a++) {
    //
    //        [self.arr0 addObject:[NSString stringWithFormat:@"%c",a]];
    //    }
    self.arr0 = @[@"刘1",@"王2",@"找2"];
    
    self.arr1 = self.arr0;
    
    self.arr2 = @[@[COLOR(73, 189, 241),COLOR(255, 153, 0),COLOR(255, 50, 0)],@[COLOR(0, 154, 0),COLOR(73, 189, 241),COLOR(255, 50, 0)],@[COLOR(0, 154, 0),COLOR(255, 153, 0),COLOR(73, 189, 241)]];
    
    for (int i = 0; i < _arr0.count; i++) {
        [self.mutArr0 addObject:@"正常"];
    }
    
    self.mutArr00 = [NSMutableArray arrayWithArray:_mutArr0];
    
    self.searchC = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchC.searchResultsUpdater = self;
    self.searchC.dimsBackgroundDuringPresentation = NO;
    self.searchC.searchBar.placeholder = @"输入学生姓名";
   
    self.searchC.hidesNavigationBarDuringPresentation = YES;
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-49)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableFooterView = [[UIView alloc]init];
    self.table.tableHeaderView = _searchC.searchBar;
    
    [self.view addSubview:_table];
    
    UIView *view0 = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-49, WIDTH, 49)];
    view0.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:view0];
    
}

- (void)creatBottomView{
    
    self.view00 = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-49, WIDTH, 49)];
    self.view00.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.view00];
    
    NSArray *arr = @[@"迟到人数",@"缺勤人数"];
    NSArray *arrr = @[COLOR(255, 153, 0),COLOR(255, 50, 0)];
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2*i, 2, WIDTH/2, 12)];
        label.text = arr[i];
        label.textAlignment = 1;
        label.font = [UIFont systemFontOfSize:10];
        [self.view00 addSubview:label];
        
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(WIDTH/4-15+WIDTH/2*i, 15, 30, 30)];
        view1.backgroundColor = arrr[i];
        view1.layer.cornerRadius = 15;
        [self.view00 addSubview:view1];
        
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(WIDTH/4-14+WIDTH/2*i, 16, 28, 28)];
        view2.backgroundColor = [UIColor whiteColor];
        view2.layer.cornerRadius = 14;
        [self.view00 addSubview:view2];
    }
    
//    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4-10, 20, 20, 20)];
//    label1.text = [NSString stringWithFormat:@"%ld",_arr0.count];
//    label1.textAlignment = 1;
//    label1.font = [UIFont systemFontOfSize:12];
//    [self.view00 addSubview:label1];
    
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4-10, 20, 20, 20)];
    self.label2.text = @"0";
    self.label2.textAlignment = 1;
    self.label2.font = [UIFont systemFontOfSize:12];
    [self.view00 addSubview:self.label2];
    
    self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4-10+WIDTH/2, 20, 20, 20)];
    self.label3.text = @"0";
    self.label3.textAlignment = 1;
    self.label3.font = [UIFont systemFontOfSize:12];
    [self.view00 addSubview:self.label3];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_searchC.active) {
        return  _arr1.count;
    }else{
        return _arr0.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"001";

    UpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        cell = [[UpdateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
//    self.cell = [[UpdateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];

    [cell.btn1 addTarget:self action:@selector(select0:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 addTarget:self action:@selector(select0:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn3 addTarget:self action:@selector(select0:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.btn1.tag = indexPath.row*10+1;
    cell.btn2.tag = indexPath.row*10+2;
    cell.btn3.tag = indexPath.row*10+3;
    
    if (_searchC.active) {
        cell.label0.text = _arr1[indexPath.row];
        cell.label1.text = _mutArr00[indexPath.row];
        
        
      
        for (int i = 0; i < _arr1.count; i++) {
            if ([_mutArr00[i] isEqualToString:@"正常"] && indexPath.row == i) {
                cell.btn1.backgroundColor = COLOR(73, 189, 241);
                cell.btn2.backgroundColor = [UIColor grayColor];
                cell.btn3.backgroundColor = [UIColor grayColor];
            }else if ([_mutArr00[i] isEqualToString:@"迟到"] && indexPath.row == i){
                cell.btn1.backgroundColor = [UIColor grayColor];
                cell.btn2.backgroundColor = COLOR(73, 189, 241);
                cell.btn3.backgroundColor = [UIColor grayColor];
            }else if ([_mutArr00[i] isEqualToString:@"缺勤"] && indexPath.row == i){
                cell.btn1.backgroundColor = [UIColor grayColor];
                cell.btn2.backgroundColor = [UIColor grayColor];
                cell.btn3.backgroundColor = COLOR(73, 189, 241);
            }

        }

    }else{
        cell.label0.text = _arr0[indexPath.row];
        cell.label1.text = _mutArr0[indexPath.row];
        for (int i = 0; i < _mutArr0.count; i++) {
            if ([_mutArr0[i] isEqualToString:@"正常"] && indexPath.row == i) {
                cell.btn1.backgroundColor = COLOR(73, 189, 241);
                cell.btn2.backgroundColor = [UIColor grayColor];
                cell.btn3.backgroundColor = [UIColor grayColor];
            }else if ([_mutArr0[i] isEqualToString:@"迟到"] && indexPath.row == i){
                cell.btn1.backgroundColor = [UIColor grayColor];
                cell.btn2.backgroundColor = COLOR(73, 189, 241);
                cell.btn3.backgroundColor = [UIColor grayColor];
            }else if ([_mutArr0[i] isEqualToString:@"缺勤"] && indexPath.row == i){
                cell.btn1.backgroundColor = [UIColor grayColor];
                cell.btn2.backgroundColor = [UIColor grayColor];
                cell.btn3.backgroundColor = COLOR(73, 189, 241);
            }
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)select0:(UIButton *)sender{
    
    if (_searchC.active) {

        if (sender.tag %10 == 1) {
            
            [self.mutArr00 replaceObjectAtIndex:(sender.tag-1)/10 withObject:@"正常"];
            
        }else if (sender.tag %10 == 2){
            
            [self.mutArr00 replaceObjectAtIndex:(sender.tag-2)/10 withObject:@"迟到"];

            
        }else if (sender.tag %10 == 3){
            
            [self.mutArr00 replaceObjectAtIndex:(sender.tag-3)/10 withObject:@"缺勤"];
            
        }

        [self update];
        
    }else{
        
        if (sender.tag %10 == 1) {
            
            [self.mutArr0 replaceObjectAtIndex:(sender.tag-1)/10 withObject:@"正常"];

        }else if (sender.tag %10 == 2){
            
            [self.mutArr0 replaceObjectAtIndex:(sender.tag-2)/10 withObject:@"迟到"];
//            NSLog(@"%ld",(sender.tag-2)/10);

        }else if (sender.tag %10 == 3){
            
            [self.mutArr0 replaceObjectAtIndex:(sender.tag-3)/10 withObject:@"缺勤"];

        }
       
    }
    
    [self.table reloadData];
    
    self.mutArr1 = [NSMutableArray arrayWithCapacity:0];
    self.mutArr2 = [NSMutableArray arrayWithCapacity:0];
    self.mutArr3 = [NSMutableArray arrayWithCapacity:0];
    self.mutArr4 = [NSMutableArray arrayWithCapacity:0];

    for (int i = 0; i < _mutArr0.count; i++) {
        if ([_mutArr0[i] isEqualToString:@"迟到"]) {
            [self.mutArr1 addObject:_arr0[i]];
            [self.mutArr3 addObject:_mutArr0[i]];
        }else if ([_mutArr0[i] isEqualToString:@"缺勤"]){
            [self.mutArr2 addObject:_arr0[i]];
            [self.mutArr4 addObject:_mutArr0[i]];
        }
        self.label2.text = [NSString stringWithFormat:@"%ld",_mutArr3.count];
        self.label3.text = [NSString stringWithFormat:@"%ld",_mutArr4.count];
    }

}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *str1 = self.searchC.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains[c] %@",str1];
    
    self.arr1 = [NSArray arrayWithArray:[self.arr0 filteredArrayUsingPredicate:predicate]];
   
    if (_arr1.count > 0) {
        for (int i = 0; i < _arr1.count; i++) {
            [self.mutArr00 replaceObjectAtIndex:i withObject:_mutArr0[[_arr0 indexOfObject:_arr1[i]]]];

        }
    }
    
    [self.table reloadData];
    
}

- (void)update{
    for (int i = 0; i < _arr1.count; i++) {
        
        [self.mutArr0 replaceObjectAtIndex:[_arr0 indexOfObject:_arr1[i]] withObject:_mutArr00[i]];
    }
}


@end
