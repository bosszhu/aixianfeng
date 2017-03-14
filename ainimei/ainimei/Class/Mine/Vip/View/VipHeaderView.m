//
//  VipHeaderView.m
//  ainimei
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "VipHeaderView.h"
#import "VipCollectionViewCell.h"
#import <Masonry.h>
#import "UIView+HMObjcSugar.h"

@interface VipHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (nonatomic, weak) UIVisualEffectView *effectView;

@property (nonatomic, strong) UICollectionView *vipCollectionView;
@property (weak, nonatomic) IBOutlet UIView *vipView;


@end
@implementation VipHeaderView
+ (instancetype)loadVipHeaderView {
    return [[[NSBundle mainBundle]loadNibNamed:@"VipHeaderView" owner:self options:nil]lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupBlurEffect];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    NSLog(@"%@",NSStringFromCGRect(self.vipView.frame));
    
    
//    flowLayout.itemSize = self.vipView.bounds.size;
    flowLayout.itemSize = CGSizeMake(200, 28);
    
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //创建collectview
//    UICollectionView *vipCollectionView = [[UICollectionView alloc]initWithFrame:self.vipView.bounds collectionViewLayout:flowLayout];
    
    UICollectionView *vipCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    vipCollectionView.showsVerticalScrollIndicator = NO;
    vipCollectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:vipCollectionView];
    vipCollectionView.delegate = self;
    vipCollectionView.dataSource =self;
    vipCollectionView.backgroundColor = [UIColor clearColor];
    self.vipCollectionView = vipCollectionView;
    
    UINib *nib = [UINib nibWithNibName:@"VipCollectionViewCell" bundle:nil];
    [vipCollectionView registerNib:nib forCellWithReuseIdentifier:@"vipCell"];
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VipCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"vipCell" forIndexPath:indexPath];

    switch (indexPath.row) {
        case 0:
        {
            cell.cellLable.text = @"注册会员";
            [UIView animateWithDuration:2 animations:^{
                cell.yellowView.hm_width = cell.hm_width - 43;
            } completion:^(BOOL finished) {
                cell.BigView.backgroundColor = [UIColor redColor];
            }];
            
        }
            break;
        case 1:
        {
            cell.cellLable.text = @"普通会员";
            cell.yellowView.hm_width = 0;
            cell.BigView.backgroundColor = [UIColor whiteColor];
        }
            
            break;
        case 2:
            {
            cell.cellLable.text = @"白银会员";
            cell.yellowView.hm_width = 0;
            cell.BigView.backgroundColor = [UIColor whiteColor];
            }
            break;
        case 3:
            {
            cell.cellLable.text = @"黄金会员";
            cell.yellowView.hm_width = 0;
            cell.BigView.backgroundColor = [UIColor whiteColor];
            }
            break;
        case 4:
            {
            cell.cellLable.text = @"钻石会员";
            cell.yellowView.hm_width = 0;
            cell.BigView.backgroundColor = [UIColor whiteColor];
            }
            break;
        case 5:
            {
            cell.cellLable.text = @"王者会员";
            cell.yellowView.hm_width = 0;
            cell.BigView.backgroundColor = [UIColor whiteColor];
            }
            
            break;
        default:
            break;
    }
    return cell;
}
#pragma mark - 模糊效果
- (void)setupBlurEffect {
   // 创建模糊效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [self.bgImageView addSubview:effectView];
    self.effectView = effectView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.effectView.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 300);
    [self.vipCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-64);
        make.height.mas_equalTo(28);
    }];
}

@end
