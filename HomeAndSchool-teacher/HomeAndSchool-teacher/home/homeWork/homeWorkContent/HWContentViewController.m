//
//  HWContentViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "HWContentViewController.h"
#import "Define.h"
#import "HWContentTableViewCell.h"
#import "UIImageView+tap.h"

@interface HWContentViewController ()

@property (strong, nonatomic)NSArray *cutImg;

@property (assign, nonatomic)BOOL isYesOrNo;

@property (assign, nonatomic)NSArray *HWImageArr;

@property (assign, nonatomic)NSArray *HWContentArr;

@property (strong, nonatomic)UIImageView *hwImage;

@property (strong, nonatomic)UIView *hwView;

@property (strong, nonatomic)UIVisualEffectView *visualEffectView;

@end

@implementation HWContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isYesOrNo = YES;
    
    self.HWImageArr = [_content objectForKey:@"image"];
    
    self.HWContentArr = [_content objectForKey:@"content"];
    
    self.hwImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 69, VIEW_WIDTH - 10, VIEW_HEIGHT - 64 - 10)];
    
    self.hwView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT - 64)];
    
    self.visualEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    
    self.visualEffectView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    
//    self.visualEffectView.alpha = 0.7;
    
    //缩放手势
    UIPinchGestureRecognizer *pinchGest = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [self.hwImage addGestureRecognizer:pinchGest];
    
    
    self.HWContentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.HWContentTable.delegate = self;
    self.HWContentTable.dataSource = self;
    self.HWContentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.HWContentTable.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview:_HWContentTable];
    
    [self navigationHader];
}

- (void)navigationHader{
    
    self.navigationItem.title = @"作业板";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 10, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    

}

- (void)leftButton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
       return self.HWContentArr.count;
        
    }else{
        
        return 1;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        CGFloat contentWidth = VIEW_WIDTH - 10;
        UIFont *font = [UIFont systemFontOfSize:15];
        NSString *content;
        content = [_content objectForKey:@"content"][indexPath.row];
        NSDictionary *dic = @{NSFontAttributeName:font};
        
        CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        return size.height + 25;
        
    }else{
        
        if (_HWImageArr.count == 1) {
            
            return 300;
            
        }else if (_HWImageArr.count >= 2 && _HWImageArr.count < 4){
            
            return 110;
            
        }else if (_HWImageArr.count > 3 && _HWImageArr.count < 7){
            
            return 220;
            
        }else if (_HWImageArr.count > 6 && _HWImageArr.count < 9){
            
            return 330;
            
        }else{
            
            return 330;
            
        }
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ssstr;
    
    if (indexPath.section == 0) {
        
        ssstr = @"cell1";

    }else{
        
        ssstr = @"cell2";
        
    }
    
    HWContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ssstr];
    
    if (cell == nil) {
        
        cell = [[HWContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ssstr];
        
    }
    
    if (indexPath.section == 0) {
        
        cell.HWcontentLabel.text = [_content objectForKey:@"content"][indexPath.row];
        
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
        int aa = 10003;
        
        for (int i = 0; i < _HWImageArr.count; i ++) {
            
            UIImageView_tap *cellimg = cell.imageArr[i];
            
            cellimg.tag = aa++;
            
            [cellimg becomeFirstResponder];
            CGSize size = CGSizeMake(100, 100);
            cellimg.image = [self cutImage:[UIImage imageNamed:_HWImageArr[i]] andCGSize:size];
            cellimg.userInteractionEnabled = YES;
            [cellimg.tapGest addTarget:self action:@selector(enlarge:)];
            
            
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//分组名的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
}

//分组名(scrollview)
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 25)];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 15, 15)];
    image.image = [UIImage imageNamed:@"bianqian"];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 25)];
    if (section == 0) {
        
        label2.text = @"文本作业";
        
    }else{
        
        label2.text = @"图片作业";
        
    }
    
    label2.font = FONT(15);
    label2.textAlignment = NSTextAlignmentCenter;
    
    [headerView addSubview:image];
    
    [headerView addSubview:label2];
    
    return headerView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image andCGSize:(CGSize)size{

    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (size.width / size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * size.height / size.width;
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * size.width / size.height;
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

- (void)enlarge:(id)sender{
    
    CGSize size = CGSizeMake(VIEW_WIDTH-10, VIEW_HEIGHT-74);

    float i1=[UIImage imageNamed:_HWImageArr[[sender view].tag - 10003]].size.width;
    float h1=[UIImage imageNamed:_HWImageArr[[sender view].tag - 10003]].size.height;
    float l=1;
    
    if(i1>size.width||h1>size.height)
    {
        while (i1>size.width||h1>size.height)
        {
            l=l+0.01;
            i1=i1/l;
            h1=h1/l;
        }
    }
    
    self.hwImage.frame = CGRectMake(10, (size.height - h1)/2, i1, h1);
    self.hwView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    self.visualEffectView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);

    self.hwImage.image = [UIImage imageNamed:_HWImageArr[[sender view].tag - 10003]];
    [self.view addSubview:_hwView];
    self.visualEffectView.alpha = 0.7;
    [self.hwView addSubview:_visualEffectView];
    [self.hwView addSubview:self.hwImage];

    self.hwImage.userInteractionEnabled = YES;
    //初始化点击手势
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGest:)];
    //设置点击次数，触发事件
    tapGest.numberOfTapsRequired = 1;
    //设置一根手指
    tapGest.numberOfTouchesRequired = 1;
    //添加到myimage上
    [self.hwImage addGestureRecognizer:tapGest];
    [self.hwView addGestureRecognizer:tapGest];
    
}
//点击手势所触发的事件
- (void)tapGest:(UITapGestureRecognizer *)longgest{
    
    self.hwImage.frame = CGRectMake(0, 0, 0, 0);
    [self.hwView addSubview:_hwImage];
    self.hwView.frame = CGRectMake(0, 0, 0, 0);
    [self.view addSubview:_hwView];
    self.visualEffectView.frame = CGRectMake(0, 0, 0, 0);
    [self.hwView addSubview:_visualEffectView];
    
}
// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}
@end
