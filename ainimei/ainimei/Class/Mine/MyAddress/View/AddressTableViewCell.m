//
//  AddressTableViewCell.m
//  ainimei
//
//  Created by user on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "AddressModel.h"

@interface AddressTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contactNameLable;
@property (weak, nonatomic) IBOutlet UILabel *telLable;
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLable;

@end


@implementation AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)changeAction:(id)sender {
   
    //传值点击了哪个按钮,tag传值确定是哪个按钮,传递模型.
    
    if ([self.delegate respondsToSelector:@selector(addressTableViewCellWithCell:)]) {
        [self.delegate addressTableViewCellWithCell:self];
    }
    
}

//重写set方法赋值
- (void)setAddressModel:(AddressModel *)addressModel {
    _addressModel = addressModel;
    self.contactNameLable.text = addressModel.accept_name;
    self.telLable.text = addressModel.telphone;
    self.detailAddressLable.text = addressModel.address;
}

@end
