//
//  setHWViewController.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZImagePickerController.h"
#import "lookHomeWorkViewController.h"

@protocol homeWorkTextDelegate <NSObject>

- (void)homeWorkContent:(NSString *)str;

@end

@interface setHWViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,homeWorkTextDelegate>

@property (strong, nonatomic)UIImageView *headImage;

@property (strong, nonatomic)UIAlertController *myAlert;

@property (strong, nonatomic)UITableView *HWContentTable;

@property (strong, nonatomic)NSMutableArray *homeWorkArr;

@property (strong, nonatomic)NSString *homeWorkStr;

@property (assign, nonatomic)id<reloadDataDelegate>delegate;

@end
