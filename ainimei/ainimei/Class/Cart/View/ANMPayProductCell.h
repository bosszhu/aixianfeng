//
//  ANMPayProductCell.h
//  ainimei
//
//  Created by kingLee on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMProductCell.h"
#import "ANMFreshModel.h"

@interface ANMPayProductCell : UITableViewCell


@property (nonatomic, strong) ANMFreshModel *freshModel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
