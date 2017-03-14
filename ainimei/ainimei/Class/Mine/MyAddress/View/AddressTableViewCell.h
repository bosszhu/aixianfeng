//
//  AddressTableViewCell.h
//  ainimei
//
//  Created by user on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;
@class AddressTableViewCell;

/// 代理
@protocol AddressModelDelegate <NSObject>

- (void)addressTableViewCellWithCell:(AddressTableViewCell *)cell;

@end

@interface AddressTableViewCell : UITableViewCell

/// 代理
@property (nonatomic, weak) id<AddressModelDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
/// 地址模型
@property (nonatomic, strong) AddressModel *addressModel;
@end
