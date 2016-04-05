//
//  settextViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "settextViewController.h"
#import "Define.h"


@interface settextViewController ()

@end

@implementation settextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(249, 249, 249, 1);
    
    [self navigationHader];
    [self textFieldView];
    
}

- (void)navigationHader{
    
    self.navigationItem.title = @"添加作业";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 10, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 60, 40)];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    rightBtn.titleLabel.font = FONT(15);
    [rightBtn addTarget:self action:@selector(rightButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
}

- (void)leftButton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightButton{

    if (_delegate != nil && [_delegate respondsToSelector:@selector(homeWorkContent:)]) {

        [_delegate homeWorkContent:self.textField.text];
    
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}

- (void)textFieldView{
    
    self.textField = [[UITextView alloc]initWithFrame:CGRectMake(0, 5, VIEW_WIDTH, 300)];
    self.textField.delegate = self;
    self.textField.font=[UIFont fontWithName:@"Arial" size:15.0];
    self.textField.backgroundColor = COLOR(249, 249, 249, 1);
    [self.view addSubview:self.textField];
    
    self.lll = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 15)];
    self.lll.text = @"请输入内容......";
    self.lll.font = FONT(15);
    self.lll.textColor = COLOR(100, 100, 100, 1);
    [self.textField addSubview:_lll];
    
    if ([_content isEqualToString:@"请添加作业......"] | [_content isEqualToString:@"11"]) {
        
        self.lll.alpha = 1;
    }else{
        self.lll.alpha = 0;
        self.textField.text = _content;
    }
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    self.lll.alpha = 0;
    
    return YES;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    self.lll.alpha = 1;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
