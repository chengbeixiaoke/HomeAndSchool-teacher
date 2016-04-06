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
#import "addImageViewController.h"

@interface setHWViewController ()

@property (assign, nonatomic)int a;

@property (strong, nonatomic)UIButton *addImageBut;

@property (strong, nonatomic)UIScrollView *imagesScroll;

@property (strong, nonatomic)NSMutableArray *imageViewArr;

@property (strong, nonatomic) UIButton *deleteBtn;

@end

@implementation setHWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.homeWorkArr = [NSMutableArray arrayWithCapacity:0];
    self.a = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageViewArr = [[NSMutableArray alloc]init];

    
    [self navigationHader];
    
    [self mainView];
    
    [self addImage];
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
        UIImage *imagess = [UIImage imageNamed:@"homeWorkBak"];
        NSArray *arrr = @[imagess];
        
        [homeWorkService setImg:arrr andHomeWorkId:1 andSubject:@"语文" andSuccess:^(NSString *str) {
            
        } andFail:^(NSString *str2) {
            
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
    
    self.HWContentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height - 35 - 10)];
    self.HWContentTable.dataSource = self;
    self.HWContentTable.delegate = self;
    self.HWContentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [frameView addSubview:_HWContentTable];
    
    UIButton *addHWContent = [[UIButton alloc]initWithFrame:CGRectMake(100, size.height - 35 - 5, 120, 35)];
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

- (void)addImage{
    
    self.addImageBut = [[UIButton alloc]initWithFrame:CGRectMake(10, (VIEW_HEIGHT - 64)/2 + 110, (VIEW_WIDTH-80)/5, (VIEW_WIDTH-80)/5)];
    [self.addImageBut setImage:[UIImage imageNamed:@"addImage.png"] forState:UIControlStateNormal];
    [self.addImageBut addTarget:self action:@selector(addImages) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.addImageBut];
    
}

- (void)addImages{
    
    addImageViewController *vc=[[addImageViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - 代理回传的照片的处理
- (void)turnImages:(NSMutableArray *)selectAllImages{
    
    self.imagesScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10, (VIEW_HEIGHT - 64)/2+110, VIEW_WIDTH - 20, (VIEW_WIDTH-80)/5)];
    self.imagesScroll.backgroundColor = [UIColor whiteColor];
    self.imagesScroll.contentOffset = CGPointMake(20, (VIEW_HEIGHT - 64)/2 +110);
    self.imagesScroll.contentSize = CGSizeMake(selectAllImages.count*((VIEW_WIDTH-80)/5+10), (VIEW_WIDTH-80)/5);
    self.imagesScroll.showsVerticalScrollIndicator = NO;
    NSMutableArray *lessTenImagesArr = [NSMutableArray arrayWithCapacity:0];
    
    if (selectAllImages.count > 9) {
        
        for (int i = 0; i < 9; i++) {
            
            [lessTenImagesArr addObject:selectAllImages[i]];
            
        }
        
    }else{
        
        lessTenImagesArr = selectAllImages;
        
    }
    
    self.imageViewArr = lessTenImagesArr;
    
    for (int i = 0; i < lessTenImagesArr.count; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*((VIEW_WIDTH-80)/5+10), 0, (VIEW_WIDTH-80)/5, (VIEW_WIDTH-80)/5)];
        imageView.image = lessTenImagesArr[i];
        imageView.tag = i + 4000;
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:longPressGesture];
        [self.imagesScroll addSubview:imageView];
    }
    
    [self.view addSubview:_imagesScroll];
}

- (void)longPress:(UILongPressGestureRecognizer *)sender{
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake((VIEW_WIDTH-80)/5-20, 0, 20, 20)];
        but.backgroundColor = [UIColor orangeColor];
        but.hidden = NO;
        but.tag = [sender view].tag;
        [but addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [[self.imagesScroll viewWithTag:[sender view].tag] addSubview:but];
    }
}

- (void)deleteImage:(UIButton *)sender{
    
    for (long int i = sender.tag; i < self.imageViewArr.count+4000-1; i++) {
        
        UIImageView *before = [self.imagesScroll viewWithTag:i];
        UIImageView *afterImage = [self.imagesScroll viewWithTag:i + 1];
        
        before.image = afterImage.image;
    }
    
    [[self.imagesScroll viewWithTag:self.imageViewArr.count + 4000 - 1] removeFromSuperview];
    [self.imageViewArr removeObjectAtIndex:sender.tag - 4000];
    self.imagesScroll.contentSize = CGSizeMake(self.imageViewArr.count*((VIEW_WIDTH-80)/5 + 10), (VIEW_WIDTH-80)/5);
    
    [sender setHidden:YES];
    
}

@end
