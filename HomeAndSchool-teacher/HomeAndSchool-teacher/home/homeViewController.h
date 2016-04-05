//
//  homeViewController.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)UICollectionView *myCollection;

@property (strong, nonatomic)NSArray *picMarkArr;

@property (strong, nonatomic)NSArray *titleLabelArr;

@end
