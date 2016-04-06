//
//  addImageViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "addImageViewController.h"
#import "Define.h"
#import "selectPicCollectionViewCell.h"

@interface addImageViewController ()

@property (strong, nonatomic)NSMutableArray *assetGroups;

@property (assign, nonatomic)BOOL clickState;

@property (strong, nonatomic)UIImageView *images;

@property (strong, nonatomic)NSMutableArray *imageArr;

@property (strong, nonatomic)NSMutableDictionary *imageDic;

@property (strong, nonatomic)NSMutableArray *selectImage;

@property (strong, nonatomic)NSMutableArray *imageNumbArr;

@end

@implementation addImageViewController

static NSInteger count = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageArr = [[NSMutableArray alloc]init];
    self.imageDic = [[NSMutableDictionary alloc]init];
    self.selectImage = [[NSMutableArray alloc]init];
    self.imageNumbArr = [[NSMutableArray alloc]init];

    [self getAllPictures];
    
    [self navigationHader];
    
    [self collectionView];
    
}

#pragma mark 定义顶部导航
- (void)navigationHader{
    
    self.navigationItem.title = [NSString stringWithFormat:@"选择照片(%d/9)",0];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 50, 44)];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = FONT(15);
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
#pragma mark 取消按钮
- (void)leftButton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark 确定按钮
- (void)rightButton:(UIButton *)sender{
    
    for (NSString *index in self.imageNumbArr) {
        
        int n = index.intValue;
        UIImage *selectedImage = [UIImage imageWithCGImage:[imageArray[n] thumbnail]];
        [self.selectImage addObject:selectedImage];
        
    }
    if (_delegate != nil && [_delegate respondsToSelector:@selector(turnImages:)]) {
        [self.delegate turnImages:self.selectImage];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSLog(@"代理方法出错！");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"程序错误，请联系客服！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];

    }
}
#pragma mark collectionView的定义
- (void)collectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.imageCollection = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    self.imageCollection.dataSource = self;
    self.imageCollection.delegate = self;
    
    [self.imageCollection registerClass:[selectPicCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.imageCollection registerClass:[selectPicCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell2"];
    
    self.imageCollection.backgroundColor = [UIColor whiteColor];
    UIEdgeInsets contentInset = self.imageCollection.contentInset;
    contentInset.top = 10;
    [self.imageCollection setContentInset:contentInset];
    
    [self.view addSubview:_imageCollection];
}
#pragma mark collectionView的cell的多少
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return imageArray.count;
}
#pragma mark 每个UICollectionViewCell展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    selectPicCollectionViewCell *cell = [self.imageCollection dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ALAsset *asset = [imageArray objectAtIndex:indexPath.row];
    cell.MyImageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
    NSString *isSelectedString = self.imageDic[@(indexPath.row)];
    if ([isSelectedString isEqualToString:@"0"]) {
        cell.selectedImageView.image = nil;
    }else{
        cell.selectedImageView.image = [UIImage imageNamed:@"选中"];
    }
    return cell;
}
#pragma mark cell的布局
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((VIEW_WIDTH-20)/3, (VIEW_WIDTH-20)/3);
    
}
#pragma mark <UICollectionViewDelegate> UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *isSelectedStr = self.imageDic[@(indexPath.row)];
    NSLog(@"%ld",(long)indexPath.row);
    
    NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    if ([isSelectedStr isEqualToString:@"0"]) {
        
        if (self.imageNumbArr.count < 9) {
            [self.imageDic setObject:@"1" forKey:@(indexPath.row)];
            [self.imageNumbArr addObject:index];
            self.navigationItem.title = [NSString stringWithFormat:@"选择照片(%ld/9)",self.imageNumbArr.count];
        }else{
            NSLog(@"只能选择九张");
        }
        
    }else if([isSelectedStr isEqualToString:@"1"]) {
        
        [self.imageDic setObject:@"0" forKey:@(indexPath.row)];
        [self.imageNumbArr removeObject:index];
        self.navigationItem.title = [NSString stringWithFormat:@"选择照片(%ld/9)",self.imageNumbArr.count];
        
    }
    [collectionView reloadData];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        
        UICollectionViewCell *cell = [self.imageCollection dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"cell2" forIndexPath:indexPath];
        
        return cell;
        
    }
    return nil;
}
#pragma mark 返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

#pragma mark 选择照片
- (void)getAllPictures{
    
    imageArray = [[NSArray alloc]init];
    
    mutableArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc]init];
    
    libary = [[ALAssetsLibrary alloc]init];
    
    __block NSInteger i = 0;
    
    __weak typeof(self) weak_self = self;
    
    void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop){
        
        if (result != nil) {
            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                NSURL *url = (NSURL *)[[result defaultRepresentation]url];
                [libary assetForURL:url resultBlock:^(ALAsset *asset) {
                    [weak_self.imageDic setObject:@"0" forKey:@(i)];
                    i++;
                    [mutableArray addObject:asset];
                    
                    if ([mutableArray count] == count) {
                        
                        imageArray = [[NSArray alloc]initWithArray:mutableArray];
                        [self allPhotosCollected:imageArray];
                        
                    }
                } failureBlock:^(NSError *error) {
                    
                    NSLog(@"operation was not successfull");
                    
                }];
            }
        }
    };
    
    _assetGroups = [[NSMutableArray alloc]init];
    void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop){
        
        if (group != nil) {
        
            [group enumerateAssetsUsingBlock:assetEnumerator];
            [_assetGroups addObject:group];
            count = [group numberOfAssets];
        
        }
    };
    _assetGroups = [[NSMutableArray alloc] init];
    [libary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:assetGroupEnumerator failureBlock:^(NSError *error) {
        NSLog(@"There is an error");
    }];


}
#pragma mark 刷新
-(void)allPhotosCollected:(NSArray*)imgArray{
    NSLog(@"all pictures are %@",imgArray);
    [self.imageCollection reloadData];
}

@end
