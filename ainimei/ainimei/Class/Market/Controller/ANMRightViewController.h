//
//  ANMRightViewController.h
//  ainimei
//
//  Created by Huster on 2016/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMFlsahMarketSource.h"
#import "ANMFlashMarketViewController.h"
@protocol ProductsDelegate<NSObject>

- (void)willDislayHeaderView:(NSInteger)section;
- (void)didEndDislayHeaderView:(NSInteger)section;


@end


@interface ANMRightViewController : UIViewController<CategoryTableViewDelagate>
@property (nonatomic,strong)  SuperMarketData *superMarketData;
@property (nonatomic,weak) id<ProductsDelegate>delegate;

@end
