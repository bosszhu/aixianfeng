//
//  DetailAddressTableViewController.h
//  ainimei
//
//  Created by user on 16/11/14.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;

@interface DetailAddressTableViewController : UITableViewController

@property (nonatomic, copy) void (^deleteModel)(AddressModel *addressModel);

@property (nonatomic, strong) AddressModel *addressModel;

/// 删除cell
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;

@end
