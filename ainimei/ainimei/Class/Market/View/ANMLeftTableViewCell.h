//
//  ANMLeftTableViewCell.h
//  ainimei
//
//  Created by Huster on 2016/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMFlsahMarketSource.h"

@interface ANMLeftTableViewCell : UITableViewCell
//数据源
@property (nonatomic,strong)ProductCategory *categroies;
//创建
+ (instancetype)cellWith:(UITableView *)tableView;
@end
