//
//  ANMFooterViewCell.h
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMFreshModel.h"

@interface ANMFooterViewCell : UICollectionViewCell

@property (nonatomic, strong) ANMFreshModel *freshModel;
@property (nonatomic, assign) BOOL cellType;

@end
