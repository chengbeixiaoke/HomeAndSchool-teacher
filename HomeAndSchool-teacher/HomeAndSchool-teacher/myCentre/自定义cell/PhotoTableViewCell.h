//
//  PhotoTableViewCell.h
//  JXT
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 LYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModePhoto1;
@interface PhotoTableViewCell : UITableViewCell

/**  mode */
@property (strong,nonatomic)ModePhoto1 *mode;

+(instancetype)cellWithTab:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;
@end
