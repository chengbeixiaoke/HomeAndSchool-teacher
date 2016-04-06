//
//  ClassTableViewCell.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClassMode;
@class HowClassMode;
@interface ClassTableViewCell : UITableViewCell

/**  模型 */
@property (strong,nonatomic)ClassMode *classMode;

/**  模型 */
@property (strong,nonatomic)HowClassMode *howClassMode;

+(instancetype)cellWithTab:(UITableView *)tableView;
@end
