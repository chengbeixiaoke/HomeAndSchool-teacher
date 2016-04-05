//
//  settextViewController.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "setHWViewController.h"

@interface settextViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic)UILabel *lll;

@property (strong, nonatomic)NSString *content;

@property (strong, nonatomic)UITextView *textField;

@property (assign, nonatomic)id<homeWorkTextDelegate>delegate;

@end
