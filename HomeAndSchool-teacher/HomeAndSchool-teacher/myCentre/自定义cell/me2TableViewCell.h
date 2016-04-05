//
//  me2TableViewCell.h
//  JXT
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 LYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class mode1;
@interface me2TableViewCell : UITableViewCell
/**  模型 */
@property (strong,nonatomic)mode1 *mode;

+(instancetype)cellWithTab:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;
@end
