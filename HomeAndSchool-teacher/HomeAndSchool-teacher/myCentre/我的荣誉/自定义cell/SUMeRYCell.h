//
//  SUMeRYCell.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/1.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RYModel;
@class MeRongYU;
@interface SUMeRYCell : UITableViewCell


/**  class模型 */
@property (strong,nonatomic)RYModel *mode;
/**  wode模型 */
@property (strong,nonatomic)MeRongYU *meMode;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
