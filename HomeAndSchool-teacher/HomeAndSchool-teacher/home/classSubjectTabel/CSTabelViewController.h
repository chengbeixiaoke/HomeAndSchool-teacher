//
//  CSTabelViewController.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSTabelViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)UICollectionView *myCollection;

@property (strong, nonatomic)NSArray *tabelArr;

@end
