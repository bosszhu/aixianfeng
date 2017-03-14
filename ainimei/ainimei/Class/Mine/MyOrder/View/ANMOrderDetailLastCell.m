//
//  ANMOrderDetailLastCell.m
//  ainimei
//
//  Created by kingLee on 16/11/17.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMOrderDetailLastCell.h"

@interface ANMOrderDetailLastCell ()
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *myImageViews;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation ANMOrderDetailLastCell

-(void)setOrderModel:(ANMMyOrderModel *)orderModel{

    _orderModel = orderModel;
    self.commentLabel.text = orderModel.comment;
    NSNumber *endNum = orderModel.star;

    NSUInteger i = 0;
    for (UIImageView *imgView  in self.myImageViews) {
        
        if (i<endNum.integerValue) {
            imgView.image = [UIImage imageNamed:@"v2_star_on"];
        }else{
            imgView.image = [UIImage imageNamed:@"v2_star_no"];
        }
        i++;
    }
}

@end
