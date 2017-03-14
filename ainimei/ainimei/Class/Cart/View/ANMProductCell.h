//
//  ANMProductCell.h
//  ainimei
//
//  Created by kingLee on 16/11/14.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMFreshModel.h"

@interface ANMProductCell : UITableViewCell
@property (nonatomic, strong) ANMFreshModel *freshModel;


//商品名字
@property (nonatomic, weak) UILabel *productNameLabel;
//商品价格
@property (nonatomic, weak) UILabel *productPriceLabel;
//商品数量
@property (nonatomic, weak) UILabel *productNumLabel;
//减少数量btn
@property (nonatomic, weak) UIButton *minusBtn;
//增加数量btn
@property (nonatomic, weak) UIButton *plusBtn;



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
