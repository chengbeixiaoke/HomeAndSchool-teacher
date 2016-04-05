//
//  MePhotoViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MePhotoViewController.h"
#import "Define.h"
#define WWIETHX(x)   [UIScreen mainScreen].bounds.size.width*x/320

@interface MePhotoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

/**  头像 */
@property (strong,nonatomic)UIImageView *image;

/** 图片2进制路径 */
@property (copy,nonatomic)NSString *filePath;
@end

@implementation MePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人头像";
        UIBarButtonItem *btn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(paizhao)];
    [self.navigationItem setRightBarButtonItem:btn];
    self.view.backgroundColor =COLOR(248, 248, 248, 1);
    
    [self duqu];

}

#pragma mark - 设置图片
-(void)duqu{
    
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 80,WWIETHX(320) , WWIETHX(320))];
    
    UIImage *images = [self duQuDocumentImage];
    
    if (images) {
        
        self.image.image = images;

    }else{
        self.image.image = [UIImage imageNamed:@"wo.png"];
    }
    
    [self.view addSubview:_image];

}

#pragma mark - 读取本地信息

-(UIImage *)duQuDocumentImage{
    
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [paths firstObject];
    
    NSString *imagePath = [document stringByAppendingPathComponent:@"image"];
    
    NSString *image = [imagePath stringByAppendingPathComponent:@"image.png"];
    
    UIImage *images = [UIImage imageWithContentsOfFile:image];
    
    return images;
}


#pragma mark - 按钮
-(void)paizhao{
    UIAlertController *alert = [[UIAlertController alloc]init];
    
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self camera];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self photoalbum];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self savePhoto];
    }];

    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    [alert addAction:action];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:action4];
    [self presentViewController:alert animated:YES completion:nil];

    
}

#pragma mark - 拍照
-(void)camera{
     UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
       
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        [self alertTitle:@"相机被禁用" delay:0];
    }
    
    
}


#pragma mark - 相册中选中
-(void)photoalbum{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    
    
}

#pragma mark - 保存图片
-(void)savePhoto{
    
   UIImageWriteToSavedPhotosAlbum(_image.image, nil, nil, nil);
    
    [self alertTitle:@"图片保存成功" delay:2];
    
}

/**
 *  弹跳框
 *
 *  @param title 标题
 *  @param delay 延迟时间
 */
-(void)alertTitle:(NSString *)title delay:(NSTimeInterval)delay{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    
    [UIView animateKeyframesWithDuration:2 delay:delay options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        
    } completion:^(BOOL finished) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];

    
}
#pragma mark - 当一个相片被选择后进入
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        #pragma mark - 进行网络请求，上传数据（）
        
        
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *imagePath = [DocumentsPath stringByAppendingPathComponent:@"image"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[imagePath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
       // 得到选择后沙盒中图片的完整路径
        self.filePath = [[NSString alloc]initWithFormat:@"%@%@",imagePath,@"/image.png"];
       
//
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.image.image = image;
    }
    
}

-(void)sendInfo
{
    NSLog(@"图片的路径是:%@", self.filePath);
    
  }

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


@end
