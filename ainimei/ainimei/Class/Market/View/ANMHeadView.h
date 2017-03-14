//
//  ANMHeadView.h
//  ainimei
//
//  Created by Huster on 2016/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ANMHeadView : UITableViewHeaderFooterView
+ (instancetype)headerCellWith:(UITableView *)tableView;

@property (nonatomic,copy) NSString *title;
@end
