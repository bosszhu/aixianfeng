//
//  ANMFlashMarketViewController.h
//  ainimei
//
//  Created by Huster on 2016/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark - tableview的联动代理方法
@protocol CategoryTableViewDelagate <NSObject>

- (void)didTableView:(UITableView *)tableView clickedAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface ANMFlashMarketViewController : UIViewController
@property (nonatomic,weak) id<CategoryTableViewDelagate>delegate;
@end
