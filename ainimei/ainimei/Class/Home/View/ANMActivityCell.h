//
//  ANMActivityCell.h
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMActivityModel.h"

@interface ANMActivityCell : UITableViewCell
@property (nonatomic, strong) ANMActivityModel *actModel;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
