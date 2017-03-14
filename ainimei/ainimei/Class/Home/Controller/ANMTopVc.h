//
//  ANMTopVc.h
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMTopModel.h"
#import "ANMBtnModel.h"

@interface ANMTopVc : UIViewController
@property (nonatomic, strong) NSArray<ANMTopModel *> *topModelArr;
@property (nonatomic, strong) NSArray<ANMBtnModel *> *btnModelArr;

@end
