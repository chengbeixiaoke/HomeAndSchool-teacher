//
//  ConversationViewController.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

#import "ResultViewController.h"


@interface ConversationViewController : RCConversationViewController

@property(assign,nonatomic)id <resultDelegate>delegate;

@end
