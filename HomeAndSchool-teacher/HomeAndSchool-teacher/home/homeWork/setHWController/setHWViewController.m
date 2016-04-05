//
//  setHWViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "setHWViewController.h"
#import "Define.h"
#import "setHWTableViewCell.h"
#import "settextViewController.h"
#import "homeWorkService.h"

@interface setHWViewController ()

@property (assign, nonatomic)int a;

@end

@implementation setHWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.homeWorkArr = [NSMutableArray arrayWithCapacity:0];
    self.a = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self navigationHader];
    [self mainView];
    
}

- (void)navigationHader{
    
    self.navigationItem.title = @"布置作业";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 50, 44)];
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = FONT(15);
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightBtn addTarget:self action:@selector(rightButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
}

- (void)leftButton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightButton{
    
    NSMutableString *mutStr = [NSMutableString stringWithCapacity:0];

    if (_homeWorkArr.count<1) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请添加作业" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *butt1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:butt1];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else if([_homeWorkArr[0] isEqualToString:@"请添加作业......"]){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请添加作业" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *butt1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:butt1];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        
        for (int i =0; i < _homeWorkArr.count; i ++) {
            
            NSString *str = _homeWorkArr[i];
            [mutStr appendFormat:@"%@#",str];
            
        }
        
        [homeWorkService setHomeWorkSubject:@"语文" andWithClass:1 andTeacherId:1 andHWContent:mutStr andTime:@"2016-2-3" andWithSuccess:^(NSString *success) {
            
            [mutStr setString:@""];
            NSLog(@"%@",success);
            
        } andWithFail:^(NSString *fail) {
            NSLog(@"%@",fail);
        }];
        
        if (_delegate != nil && [_delegate respondsToSelector:@selector(reload)]) {
            
            [_delegate reload];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
}

- (void)homeWorkContent:(NSString *)str{
    
    if ([str isEqualToString:@""]||[str isEqualToString:@"请添加作业......"]) {
    }else{
        [self.homeWorkArr addObject:str];
    }
    
    [self.HWContentTable reloadData];
    
}

- (void)mainView{
    
    UIView *frameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, (VIEW_HEIGHT - 64)/2 + 100)];
    frameView.backgroundColor  = COLOR(249, 249, 249, 1);
    [self.view addSubview:frameView];
    
    CGSize size = frameView.frame.size;
    
    self.HWContentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, size.width, 300)];
    self.HWContentTable.dataSource = self;
    self.HWContentTable.delegate = self;
    self.HWContentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [frameView addSubview:_HWContentTable];
    
    UIButton *addHWContent = [[UIButton alloc]initWithFrame:CGRectMake(100, 310, 120, 34)];
    [addHWContent setTitle:@"+点击添加" forState:UIControlStateNormal];
    [addHWContent setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    addHWContent.titleLabel.font = FONT(15);
    addHWContent.layer.borderColor = COLOR(245, 245, 245, 1).CGColor;
    addHWContent.layer.borderWidth = 1;
    addHWContent.layer.cornerRadius = 5;
    addHWContent.backgroundColor = [UIColor whiteColor];
    [frameView addSubview:addHWContent];
    [addHWContent addTarget:self action:@selector(addHWContentText) forControlEvents:UIControlEventTouchDown];
    
}

- (void)addHWContentText{
    
    settextViewController *setTextVc = [[settextViewController alloc]init];
    setTextVc.delegate = self;
    setTextVc.content = @"11";
    [self.navigationController pushViewController:setTextVc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_homeWorkArr.count == 0) {
        return 1;
    }else{
        return _homeWorkArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_homeWorkArr.count == 0) {
        return 30;
    }else{
        CGFloat contentWidth = VIEW_WIDTH - 25;
        UIFont *font = FONT(15);
        NSString *content;
        content = _homeWorkArr[indexPath.row];
        NSDictionary *dic = @{NSFontAttributeName:font};
        CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        return size.height + 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    setHWTableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[setHWTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    if (_homeWorkArr.count == 0) {
       cell.HWcontentLabel.text = @"请添加作业......";
    }else{
      cell.HWcontentLabel.text = _homeWorkArr[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    setHWTableViewCell *cell = (setHWTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    settextViewController *setTextVc = [[settextViewController alloc]init];
    setTextVc.delegate = self;
    setTextVc.content = cell.HWcontentLabel.text;
    [self.homeWorkArr removeObject:cell.HWcontentLabel.text];
    [self.navigationController pushViewController:setTextVc animated:YES];
    
}

@end
