//
//  ConversationViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "ConversationViewController.h"

@interface ConversationViewController ()

@property(strong,nonatomic)UIButton *back;

@end

@implementation ConversationViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self BuildView];
    
    
    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden=NO;
    
    
}


- (void)BuildView{

    
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(0, 2, 25, 40)];
    
    back.contentEdgeInsets=UIEdgeInsetsMake(0, -25, 0, 0);
    
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [back addTarget:self action:@selector(leftBarButtonItemPressed:) forControlEvents:UIControlEventTouchDown];
    self.back=back;
    
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc]initWithCustomView:_back];
    
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    
    
    



}

- (void)leftBarButtonItemPressed:(id)sender{

    [super leftBarButtonItemPressed:sender];
    
    if (sender==_back) {
        
        if (_delegate!=nil&&[_delegate respondsToSelector:@selector(navgationbarHidden)]) {
            
            [_delegate navgationbarHidden];
            
        }
        
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
