//
//  ANMGuideCollectionViewCell.m
//  ainimei
//
//  Created by user on 16/11/17.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMGuideCollectionViewCell.h"

@interface ANMGuideCollectionViewCell ()
@property (nonatomic, weak) UIImageView *imageView;

@end
@implementation ANMGuideCollectionViewCell
- (void)setGuideImage:(UIImage *)guideImage {
    _guideImage = guideImage;
    _imageView.image = guideImage;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //创建ImageVeiw
        UIImageView *imageView = [UIImageView new];
        [self.contentView addSubview:imageView];
        _imageView = imageView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}
@end
