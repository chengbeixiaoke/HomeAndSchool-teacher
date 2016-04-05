//
//  friendViewController.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "friendViewController.h"

#import "model/MyTableViewCell.h"

#import "ConversationViewController.h"

#import "AddFriendViewController.h"

#import "Define.h"

#import "PersonalInfo.h"


@interface friendViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property(strong,nonatomic)UITableView *myTableView;

@property(strong,nonatomic)UIScrollView *scrollView;

@property(strong,nonatomic)UITableView *groupTableView;

@property(assign,nonatomic)long int a;

@property(strong,nonatomic)UISearchBar *search;

@property(strong,nonatomic)UIView *listView;

@property(assign,nonatomic)BOOL isClick;

@property(strong,nonatomic)UIVisualEffectView *visualEffectView;

@property(strong,nonatomic)UIButton *addFriend;

@property(strong,nonatomic)UIButton *jionGroup;

@property(strong,nonatomic)UIButton *creatGroup;

@end

@implementation friendViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self BulidView];
    
    self.navigationController.navigationBar.barStyle=1;

    self.a=100;
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    
    self.isClick=NO;
    
    

    
       
}


- (UISearchBar *)search{

    if (!_search) {
        _search=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
       
        _search.placeholder=@"搜索";
        
        _search.delegate=self;
             }
    
        return _search;



}


//- (UIView *)listView{
//
//    if (!_listView) {
//        _listView=[[UIView alloc]initWithFrame:CGRectMake(300, 74, 0, 0)];
//        
//        _listView.backgroundColor=[UIColor redColor];
//    }
//
//
//    return _listView;
//}



#pragma mark 建立视图

- (void)BulidView{

    //添加好友
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showList)];
    
    self.navigationItem.rightBarButtonItem=right;
    
    //菜单
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    self.listView=[[UIView alloc]init];
    
    self.listView.backgroundColor=[UIColor whiteColor];
    
     self.addFriend=[[UIButton alloc]init];
    
   [self.addFriend setAttributedTitle:[self Convert:@"添加好友" Color:[UIColor grayColor] Front:FONT(12)] forState:UIControlStateNormal];
    
    [self.addFriend addTarget:self action:@selector(addFriends) forControlEvents:UIControlEventTouchDown];
    
    [self.listView addSubview:_addFriend];
    
    self.jionGroup=[[UIButton alloc]init];
    
    [self.jionGroup setAttributedTitle:[self Convert:@"加入群组" Color:[UIColor grayColor] Front:FONT(12)] forState:UIControlStateNormal];

    [self.listView addSubview:_jionGroup];
    
    self.creatGroup=[[UIButton alloc]init];
    
    [self.creatGroup setAttributedTitle:[self Convert:@"创建群组" Color:[UIColor grayColor] Front:FONT(12)] forState:UIControlStateNormal];
    [self.listView addSubview:_creatGroup];
    
    
    self.visualEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    
   self.visualEffectView.frame = self.view.frame;
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoom)];
    
    _visualEffectView.alpha=0.2;
    
    _visualEffectView.hidden=YES;
    
    [_visualEffectView addGestureRecognizer:tapGesture];
    
    [window addSubview:_visualEffectView];
    
    [window addSubview:_listView];

    //好友
    self.myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, 460)];

    self.myTableView.showsVerticalScrollIndicator=NO;
    
    self.myTableView.delegate=self;
    
    self.myTableView.dataSource=self;
    
    self.myTableView.tableFooterView=[[UIView alloc]init];
    
    
   //群组
    self.groupTableView=[[UITableView alloc]initWithFrame:CGRectMake(320, 64, 320, 460)];
    
    self.groupTableView.delegate=self;
    
    self.groupTableView.dataSource=self;
    
    self.groupTableView.tableFooterView=[[UIView alloc]init];
    
    self.groupTableView.showsVerticalScrollIndicator=NO;
    
    
    //UINavigationBar titleView自定义
    
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 5, 80, 25)];
    
    titleView.backgroundColor=[UIColor whiteColor];
    
    titleView.layer.borderWidth=1;
    
    titleView.layer.borderColor=[UIColor whiteColor].CGColor;
    
    titleView.layer.cornerRadius=6;
    
    self.navigationItem.titleView=titleView;
    
    
    UIButton *private=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 25)];
    
    private.tag=100;
    
    
   [private setAttributedTitle:[self Convert:@"好友" Color:RGB(82, 189, 239, 1) Front:FONT(11)] forState:UIControlStateNormal];
    
    
    private.backgroundColor=[UIColor whiteColor];
    
    
    [self UIView:private Corners:(UIRectCornerBottomLeft|UIRectCornerTopLeft) CornorRadius:6];
    
    [private addTarget:self action:@selector(ChangeTo:) forControlEvents:UIControlEventAllTouchEvents];
    
    [self.navigationItem.titleView addSubview:private];
    
    
    UIButton *group=[[UIButton alloc]initWithFrame:CGRectMake(40, 0, 40, 25)];
    
    group.tag=101;
    
  
    [group setAttributedTitle:[self Convert:@"群组" Color:[UIColor whiteColor] Front:FONT(11)] forState:UIControlStateNormal];

    
    [group addTarget:self action:@selector(ChangeTo:) forControlEvents:UIControlEventAllTouchEvents];
    
    
    
    group.backgroundColor=RGB(82, 189, 239, 1);
    
    
    [self UIView:group Corners:(UIRectCornerBottomRight|UIRectCornerTopRight) CornorRadius:6];
    
    [self.navigationItem.titleView addSubview:group];
    
    
    //好友群组之间切换
    
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    
    
    scrollView.contentSize=CGSizeMake(320*2, 568);
    
    scrollView.scrollEnabled=NO;
    
    scrollView.backgroundColor=[UIColor whiteColor];
    
    self.scrollView=scrollView;
    
    [self.view addSubview:_scrollView];
    
    
    [_scrollView addSubview:_myTableView];
    
    [_scrollView addSubview:_groupTableView];
    
    

}

    
    



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 70.0;
}

#pragma mark 聊天跳转

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    MyTableViewCell *cell=(MyTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    
    if (tableView==self.myTableView) {
        
        
        PersonalInfo *person=[[PersonalInfo alloc]init];
        
        
        [self.navigationController pushViewController:person animated:YES];
        
       
    }else{
    
        ConversationViewController *chat = [[ConversationViewController alloc]init];
        
        chat.conversationType = 3;
        
        
            chat.targetId = @"666";

        chat.title = cell.UserName.text;
        
        [self.navigationController pushViewController:chat animated:YES];
           }
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *str;
    
    if (tableView==self.groupTableView){
    
        str=@"cell";
    
    }else{
    
    str=@"cell0";
    
    }

    MyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell==nil) {
        cell=[[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    
    if (tableView==self.groupTableView) {
        
        cell.UserName.text=@"信计二班";
        
       

        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.3761.com/uploads/attachments/image/2015-08/20150807090857_39883.jpg"]];
        
        cell.UserPic.image=[UIImage imageWithData:data];
        
    }else{
    
    cell.UserName.text=@"小明";
        
    cell.UserPic.image=[UIImage imageNamed:@"试用"];
        
    }
    
    if (self.search) {
        self.search=nil;
    }
    
    
    tableView.tableHeaderView=self.search;

    
    
    
    return cell;
}


#pragma  mark 边角设置

- (void)UIView:(UIView*)UIview Corners:(UIRectCorner)corners CornorRadius:(CGFloat)value{
    
    CAShapeLayer *shap=[CAShapeLayer layer];
    
    shap.path=[UIBezierPath bezierPathWithRoundedRect:UIview.bounds byRoundingCorners:corners  cornerRadii:CGSizeMake(value, value)].CGPath;
    
    UIview.layer.mask=shap;
    
    UIview.clipsToBounds=YES;
    
    
}

#pragma mark 文字变换

- (NSMutableAttributedString *)Convert:(NSString*)Str Color:(UIColor*)Color Front:(UIFont*) Font{
    
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:Str];
    
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleNone] range:NSMakeRange(0,str.length)];
    
    [str addAttribute:NSForegroundColorAttributeName value:Color range:NSMakeRange(0,str.length)];
    
    [str addAttribute:NSFontAttributeName value:Font range:NSMakeRange(0, str.length)];
    
    return str;
    
}


- (void)ChangeTo:(UIButton *)sender{
    
    
    if (self.a!=sender.tag) {
        
        UIButton *btn=(UIButton *)[self.navigationItem.titleView viewWithTag:self.a];
        
        btn.backgroundColor=[UIColor colorWithRed:82.0/255.0 green:189/255.0 blue:239.0/255.0 alpha:1];
        
        
        [btn setAttributedTitle:[self Convert:btn.titleLabel.text Color:[UIColor whiteColor] Front:FONT(11)] forState:UIControlStateNormal];
        
    }else{
        
        sender.backgroundColor=[UIColor whiteColor];
        
        
        [sender setAttributedTitle:[self Convert:sender.titleLabel.text Color:RGB(82, 189, 239, 1) Front:FONT(11)] forState:UIControlStateNormal];
        
    }
    
    
    if (sender.tag==100) {
        
        self.scrollView.contentOffset=CGPointMake(0, 0);
    
    
        [self.myTableView reloadData];
        
    }
    if (sender.tag==101) {
        

    
        self.scrollView.contentOffset=CGPointMake(320, 0);
        
        
        [self.groupTableView reloadData];
    
    }
    
    
    
    self.a=sender.tag;
    
}


- (void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];
    
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);


}





- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    
    ResultViewController *Rvc=[[ResultViewController alloc]init];
    
    
    [self.navigationController pushViewController:Rvc animated:NO];
    
    
    return NO;
}

- (void)showList{
    
    
    
    self.addFriend.frame=CGRectMake(0, 0, 80, 30);
    
    self.jionGroup.frame=CGRectMake(0, 35, 80, 30);
    
    self.creatGroup.frame=CGRectMake(0, 70, 80, 30);
    
    self.listView.frame=CGRectMake(220, 74, 80, 100);
        

    self.visualEffectView.hidden=NO;
    
    self.listView.alpha=1;


}

#pragma mark 添加好友

- (void)addFriends{


      [self zoom];
    
    
        AddFriendViewController *Avc=[[AddFriendViewController alloc]init];
        
        
        [self.navigationController pushViewController:Avc animated:YES];

        
   
}


- (void)zoom{

        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.listView.frame=CGRectMake(300, 74, 0, 0);
            
            self.addFriend.frame=CGRectMake(0, 0, 0, 0);
            
            self.jionGroup.frame=CGRectMake(0, 0, 0, 0);
            
            self.creatGroup.frame=CGRectMake(0, 0, 0, 0);
            
            self.listView.alpha=0;
            
        }];
         
            self.visualEffectView.hidden=YES;
   
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
