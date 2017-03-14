//
//  ANMOrderCell.h
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMGoodsModel.h"

@interface ANMOrderCell : UITableViewCell

@property (nonatomic, strong) NSArray<ANMGoodsModel*> *goodsArr;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
