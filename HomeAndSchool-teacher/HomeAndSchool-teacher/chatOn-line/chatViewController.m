//
//  chatViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "chatViewController.h"

#import "ConversationViewController.h"

#import "ResultViewController.h"

#import "MyDate.h"

@interface chatViewController ()<UISearchBarDelegate>

@property(strong,nonatomic)UISearchBar *search;


@end

@implementation chatViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息";
    
    self.navigationController.navigationBar.barStyle=1;
//    self.navigationController.navigationBar.translucent = NO;
    
    [self BulidView];
   
        
//    NSDictionary *dic=@{@"userId":@"1583066886",@"groupId":@"666",@"groupName":@"测试群"};
//    
//    
//    [MyDate CreatGroup:dic andSuccess:^(NSString *tips) {
//        
//    }];
    
    [self setAutomaticallyAdjustsScrollViewInsets:YES]; [self setExtendedLayoutIncludesOpaqueBars:YES];
    
   }


#pragma mark 建立视图
- (void)BulidView{
    
    
    //空白视图
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(80, 200, 160, 140)];
    
    imageView.image=[UIImage imageNamed:@"提示"];
    
    self.emptyConversationView=imageView;
    
    self.conversationListTableView.tableFooterView=[[UIView alloc]init];
    
    [self CreatSearch];
    
    self.conversationListTableView.tableHeaderView=self.search;
    
    //会话类型
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP)]];
    
    //同类型集中显示
    //[self setDisplayConversationTypeArray:@[@(ConversationType_PRIVATE)]];

    

    
}


#pragma mark search


- (void)CreatSearch{

   
    
    
    self.search=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    self.search.placeholder=@"搜索";
    
    self.search.delegate=self;
    
    
}







- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
conversationModel:(RCConversationModel *)model
atIndexPath:(NSIndexPath *)indexPath{

    ConversationViewController *chat = [[ConversationViewController alloc]init];
    
    chat.conversationType =model.conversationType;
   
    chat.targetId =model.targetId;
    
    chat.title =model.conversationTitle;
    
    [self.navigationController pushViewController:chat animated:YES];
    
}

- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource{

  
        return dataSource;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{


    ResultViewController *Rvc=[[ResultViewController alloc]init];
    
    
    Rvc.userModel=[NSArray arrayWithArray: self.conversationListDataSource];
    
    [self.navigationController pushViewController:Rvc animated:NO];
    

    return NO;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
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
