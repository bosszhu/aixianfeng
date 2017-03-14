//
//  ANMOrderDetailCell.h
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMGoodsModel.h"

@interface ANMOrderDetailCell : UITableViewCell

@property (nonatomic, strong) ANMGoodsModel *goodsModel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
