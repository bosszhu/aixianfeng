//
//  ANMRightTableViewCell.h
//  ainimei
//
//  Created by Huster on 2016/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMFreshModel.h"

@interface ANMRightTableViewCell : UITableViewCell
@property (nonatomic,strong)ANMFreshModel * foods;

+ (instancetype)creatRightCellWith:(UITableView *)tableView;

@end
