//
//  addImageViewController.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "setHWViewController.h"
#include <AssetsLibrary/AssetsLibrary.h>
//#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>


@interface addImageViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

{
    ALAssetsLibrary *libary;
    PHPhotoLibrary *PHPhotoLibrary;
    NSArray *imageArray;
    NSMutableArray *mutableArray;
}

@property (assign, nonatomic)id<turnBackDelegate>delegate;

@property (strong, nonatomic)UICollectionView *imageCollection;

- (void)allPhotosCollected:(NSArray *)imageArr;

@end
