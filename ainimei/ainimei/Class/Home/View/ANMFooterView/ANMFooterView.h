//
//  ANMFooterView.h
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMFreshModel.h"

@interface ANMFooterView : UIView

@property (nonatomic, copy) NSString *callNum;
@property (nonatomic, copy) NSString *requestUrl;
@property (nonatomic, assign) BOOL isHidden;

- (instancetype)initWithFrame:(CGRect)frame callNum:(NSString *)callNum urlString:(NSString *)urlString andIsHidenCell:(BOOL)isHidden;

@end
