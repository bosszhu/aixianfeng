//
//  CouponHeaderView.m
//  ainimei
//
//  Created by user on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "CouponHeaderView.h"

@implementation CouponHeaderView

+ (instancetype)loadCouponHeaderView {
    return [[[NSBundle mainBundle]loadNibNamed:@"CouponHeaderView" owner:self options:nil]lastObject];;
}
@end
