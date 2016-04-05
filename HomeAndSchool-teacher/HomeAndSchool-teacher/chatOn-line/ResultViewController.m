//
//  ResultViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "ResultViewController.h"

#import "ConversationViewController.h"

@interface ResultViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property(strong,nonatomic)NSMutableArray *userName;






@end

@implementation ResultViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.search becomeFirstResponder];
    
    self.tabBarController.tabBar.hidden=YES;
    


}

- (void)viewDidLoad {
    [super viewDidLoad];
     

    self.navigationController.navigationBarHidden=YES;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
   self.MyTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, 320, 568)];
    
    self.MyTableView.tableHeaderView=[[UIView alloc]init];
    
    
    self.MyTableView.dataSource=self;
    
    self.MyTableView.delegate=self;
    
    [self.view addSubview:_MyTableView];
    
    UISearchBar *search=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    search.delegate=self;
    
    search.showsCancelButton=YES;
    
    self.search=search;

    self.MyTableView.tableHeaderView=_search;
    
    self.MyTableView.tableFooterView=[[UIView alloc]init];
    
     self.userName=[[NSMutableArray alloc]init];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _userName.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    static NSString *str;
    
    str=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    if (_userName.count>0) {
        
         cell.textLabel.text=_userName[indexPath.row];
       
        
    }

   
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    UITableViewCell *cell=(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    for (RCConversationModel *model in self.userModel) {
        
        if ([cell.textLabel.text isEqualToString:model.conversationTitle]) {
            
            
            ConversationViewController *chat = [[ConversationViewController alloc]init];
            
            chat.conversationType =model.conversationType;
            
            chat.targetId =model.targetId;
            
            chat.title =model.conversationTitle;
            
            chat.delegate=self;
            
            [self.navigationController pushViewController:chat animated:YES];
            
            
        }
        
    }
    

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{

    [self.navigationController popViewControllerAnimated:NO];

}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    
    for (RCConversationModel *model in self.userModel) {
        
    
        [self.userName addObject:model.conversationTitle];
   
    }
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"self contains[c] %@",searchText];
    
    self.userName=[NSMutableArray arrayWithArray:[_userName filteredArrayUsingPredicate:predicate]];
    
    if (_userName.count>0) {
        
        [self.MyTableView reloadData];

    }
    

    

}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden=NO;
    
    self.tabBarController.tabBar.hidden=NO;
}


- (void)endUpdates{


    [self.userName removeAllObjects];

}

- (void)navgationbarHidden{


    self.navigationController.navigationBarHidden=YES;
    
    self.tabBarController.tabBar.hidden=YES;

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
