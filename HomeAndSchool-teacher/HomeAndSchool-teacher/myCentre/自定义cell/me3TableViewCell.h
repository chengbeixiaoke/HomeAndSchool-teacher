//
//  me3TableViewCell.h
//  JXTSU
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 LYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class mode2;
@interface me3TableViewCell : UITableViewCell


/**  moxing */
@property (strong,nonatomic)mode2 *mode;
+(instancetype)cellWithTab:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;
@end
