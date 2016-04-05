//
//  AddFriendViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.search.showsCancelButton=NO;
    
    self.MyTableView.scrollEnabled=NO;
    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
   // return _userName.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *str;
    
    str=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
//    if (_userName.count>0) {
//        
//        cell.textLabel.text=_userName[indexPath.row];
//        
//        
//    }
    
    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //UITableViewCell *cell=(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    
            
    
        
    
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    
    //NSPredicate *predicate=[NSPredicate predicateWithFormat:@"self contains[c] %@",searchText];
    
   // self.userName=[NSMutableArray arrayWithArray:[_userName filteredArrayUsingPredicate:predicate]];
    
    
    [self.MyTableView reloadData];
    
    
}





- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    NSLog(@"找不到%@",searchBar.text);
    
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
