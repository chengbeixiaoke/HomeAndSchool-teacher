//
//  PersonalInfo.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "PersonalInfo.h"

#import "ConversationViewController.h"

#import "Define.h"

@interface PersonalInfo ()



@end

@implementation PersonalInfo

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden=YES;
    
    self.navigationController.navigationBarHidden=YES;

    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self creatView];
    
}


- (void)creatView{

//
//    UIView *tablebar=[[UIView alloc]initWithFrame:CGRectMake(0, 524, 320, 44)];
//    
//    
//    tablebar.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    
//
//    [self.view addSubview:tablebar];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 523, 320, 0.2)];
    
    label.backgroundColor=[UIColor grayColor];
    
    [self.view addSubview:label];
    
    UIButton *message=[[UIButton alloc]initWithFrame:CGRectMake(20, 530, 130, 30)];
    
    message.layer.cornerRadius=5;
    
    message.layer.borderWidth=0.2;
    
    message.backgroundColor=[UIColor whiteColor];
    
    message.layer.borderColor=[UIColor grayColor].CGColor;
    
    [message setTitle:@"发消息" forState:UIControlStateNormal];
    
    [message setTitleColor:COLOR(46, 184, 245, 1) forState:UIControlStateNormal];
    
    [message addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:message];
    
    
    UIButton *telephone=[[UIButton alloc]initWithFrame:CGRectMake(170, 530, 130, 30)];
    
    telephone.layer.cornerRadius=5;
    
    telephone.layer.borderWidth=0.2;
    
    telephone.backgroundColor=[UIColor whiteColor];
    
    telephone.layer.borderColor=[UIColor grayColor].CGColor;
    
    [telephone setTitle:@"打电话" forState:UIControlStateNormal];
    
    [telephone setTitleColor:COLOR(46, 184, 245, 1) forState:UIControlStateNormal];
    

    [self.view addSubview:telephone];

    
    
    UIImageView *myImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    
    myImage.image=[UIImage imageNamed:@"背景.jpg"];
    
    
    [self.view addSubview:myImage];
    
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [back addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:back];
    
    
    
    
    UILabel *address=[[UILabel alloc]initWithFrame:CGRectMake(0, 290, 320, 80)];
    
    address.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    address.text=@"    家庭住址          苏州高博";
    
    [self.view addSubview:address];
    
    
    
    UILabel *telephoneNumber=[[UILabel alloc]initWithFrame:CGRectMake(0, 380, 320, 80)];
    
    telephoneNumber.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    telephoneNumber.text=@"    联系方式              110";
    
    [self.view addSubview:telephoneNumber];
    
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(0, 200, 320, 80)];
    
    name.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    name.text=@"盖哥（老师）";
    
    name.textAlignment=1;
    
    [self.view addSubview:name];
    
    UIImageView *userPic=[[UIImageView alloc]initWithFrame:CGRectMake(20, 160, 80, 80)];
    
    userPic.layer.cornerRadius=40;
    
    userPic.clipsToBounds=YES;
    
    NSData *date=[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img0.pconline.com.cn/pconline/1508/12/6819239_001_thumb.jpg"]];
    
    userPic.image=[UIImage imageWithData:date];
    
    [self.view addSubview:userPic];

}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden=NO;
    
    self.navigationController.navigationBarHidden=NO;

}


- (void)backTo{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendMessage{

    ConversationViewController *chat = [[ConversationViewController alloc]init];
    
    chat.conversationType = 1;
    
    chat.targetId=@"18790591074";
    
    chat.title=@"盖哥";
    
    [self.navigationController pushViewController:chat animated:YES];



}


- (BOOL)prefersStatusBarHidden{

    return YES;

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
