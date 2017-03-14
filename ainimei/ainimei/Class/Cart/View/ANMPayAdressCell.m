//
//  ANMPayAdressCell.m
//  ainimei
//
//  Created by kingLee on 16/11/17.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMPayAdressCell.h"

@interface ANMPayAdressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;

@end

@implementation ANMPayAdressCell

-(void)setAdressModel:(AddressModel *)adressModel{
    _adressModel = adressModel;
    NSUInteger num =  adressModel.gender.integerValue;
    NSString *gender = num?@"先生":@"女士";
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",adressModel.accept_name,gender];
    self.telephoneLabel.text = adressModel.telphone;
    self.adressLabel.text = [NSString stringWithFormat:@"%@ %@", adressModel.address,adressModel.city_name];
    
}

@end
