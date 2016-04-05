//
//  homeViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "homeViewController.h"
#import "Define.h"
#import "homeCollectionViewCell.h"
#import "KaoqinViewController.h"
#import "homeHader.h"
#import "CSTabelViewController.h"

@interface homeViewController ()

@property (strong, nonatomic)UIImageView *titleImage;

@end

@implementation homeViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(249, 249, 249, 1);
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 250)];
    
    self.titleImage.image = [UIImage imageNamed:@"bakImage"];
    
    [self.view addSubview:_titleImage];
    
    self.picMarkArr = @[@"homeWork",@"classTabel",@"attendance",@"notify",@"academic",@"leve"];
    self.titleLabelArr = @[@"发布作业",@"课程表",@"考勤",@"发布公告",@"成绩池",@"请假审批"];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 1;
    
    self.myCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 230, VIEW_WIDTH, (0.66* VIEW_WIDTH)) collectionViewLayout:flow];
    self.myCollection.delegate = self;
    self.myCollection.dataSource = self;
    self.myCollection.showsVerticalScrollIndicator = NO;
    self.myCollection.backgroundColor = COLOR(240, 240, 245, 1);
    [self.myCollection registerClass:[homeCollectionViewCell class] forCellWithReuseIdentifier:@"111"];
    self.myCollection.scrollEnabled = NO;
    [self.view addSubview:_myCollection];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 6;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    homeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"111" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.titleLabel.text = _titleLabelArr[indexPath.row];
    
    cell.picMark.image = [UIImage imageNamed:_picMarkArr[indexPath.row]];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    float from = VIEW_WIDTH/3;
    
    if (indexPath.row >= 3) {
        return CGSizeMake(from-0.5, from-0.5);
    }else{
        
        return CGSizeMake(from-0.5, from-0.5);
        
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        lookHomeWorkViewController *lookHomeWorkVc = [[lookHomeWorkViewController alloc]init];
        [self.navigationController pushViewController:lookHomeWorkVc animated:YES];
        
    }else if(indexPath.row == 1){
        
        CSTabelViewController *CSTabelVc = [[CSTabelViewController alloc]init];
        [self.navigationController pushViewController:CSTabelVc animated:YES];
        
    }else if(indexPath.row == 2){
    
        KaoqinViewController *kvc = [[KaoqinViewController alloc]init];
        [self.navigationController pushViewController:kvc animated:YES];
        
    }
}

@end
