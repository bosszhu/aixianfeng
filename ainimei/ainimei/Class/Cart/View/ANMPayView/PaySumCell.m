//
//  PaySumCell.m
//  ainimei
//
//  Created by kingLee on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "PaySumCell.h"
#import "ANMCartSingle.h"

@interface PaySumCell ()
@property (weak, nonatomic) IBOutlet UILabel *sumPriceLabel;

@end

@implementation PaySumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sumPriceLabel.text =[NSString stringWithFormat:@"合计:$%.1f",[ANMCartSingle sharedCart].sumPrice];
}



@end
