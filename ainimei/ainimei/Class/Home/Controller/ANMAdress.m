//
//  ViewController.m
//  mapTwo
//
//  Created by Huster on 2016/11/17.
//  Copyright © 2016年 Huster. All rights reserved.
//

#import "ANMAdress.h"
#import "Masonry.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DetailAddressTableViewController.h"
//#import "VipTableViewController.h"
#define maxBounds [UIScreen mainScreen].bounds
//页面展示
@interface ANMAdress ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate, MKMapViewDelegate>
@property(nonatomic,weak)UIView *left;
@property(nonatomic,weak)UITableView *right;
@property(nonatomic,weak)UISegmentedControl *segment;
@property(nonatomic,weak)UIView *lastView;
@property(nonatomic,weak)UIButton *topButton;
@property(nonatomic,weak)UIImageView *centerImageView;
//跳转按钮
@property(nonatomic,weak)UIButton *PushButton;

/**********地图***********/
/** 地图视图 */
@property (weak, nonatomic) MKMapView *mapView;
@property(weak,nonatomic)UILabel *locationLable;

/** 定位管理器 */
@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property(assign,nonatomic)CLLocationCoordinate2D center;

@end

@implementation ANMAdress

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeLetfView];
    [self makeTheHead];
    
    [self makeTheRight];
    
    [self.segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
   
}
#pragma mark -头部
- (void)makeTheHead{
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"送货上门",@"店铺自提"]];
    [segment setWidth:80 forSegmentAtIndex:0];
    [segment setWidth:80 forSegmentAtIndex:1];
    
//    /3.3设置默认的选中
    segment.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = segment;
    [segment setBackgroundImage:[UIImage imageNamed:@"v2_coupon_verify_selected"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    //字体颜色
    
    [segment setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor whiteColor]
                                      } forState:UIControlStateNormal];
    
    [segment setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor whiteColor]
                                      } forState:UIControlStateSelected];
    
     _segment = segment;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self segmentClick:_segment];
}

#pragma mark - 左边

- (void)makeLetfView{
    
    //整个页面
    UIView *left = [[UIView alloc]initWithFrame:maxBounds];
    left.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:left];
    self.left = left;
    
    //底部的VIew
    UIView *bottonView = [[UIView alloc]initWithFrame:CGRectMake(0, maxBounds.size.height - 44, maxBounds.size.width, maxBounds.size.height)];
    bottonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottonView];
    self.lastView = bottonView;
    
    //底部跳转页面的button
    UIButton *addrseeButton = [UIButton new];
    addrseeButton.backgroundColor = [UIColor yellowColor];

    addrseeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter ;//设置文字位置，现设为居左，默认的是居中
    [addrseeButton setTitle:@"+新增地址"forState:UIControlStateNormal];
   
    [addrseeButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    
    _PushButton = addrseeButton;
    [addrseeButton addTarget:self action:@selector(didClickTheAdress:) forControlEvents:UIControlEventTouchUpInside];
    [self.lastView addSubview:addrseeButton];
    
    
    //顶部的button
    UIButton *topButton = [[UIButton alloc]init];
    topButton.backgroundColor = [UIColor whiteColor];
    [topButton setTitle:@"定位到当前的位置" forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [topButton addTarget:self action:@selector(didTopButton:) forControlEvents:UIControlEventTouchUpInside];
    _topButton = topButton;
    
    
   UIImageView *imageView =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_address_locate"]];
     UIImageView *go =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_go"]];
    
    [self.view addSubview:topButton];
    [topButton addSubview:imageView];
    [topButton addSubview:go];
    
    [go mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topButton.mas_right).offset(-50);
        make.top.equalTo(topButton.mas_top).offset(20);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topButton.mas_top).offset(10);
        make.centerX.equalTo(topButton.mas_centerX).offset(-90);
    }];
    
    //中间的图片
    UIView *centerView= [[UIView alloc]init];
    centerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:centerView];
    UIImageView *centerimageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_address_empty"]];
    self.centerImageView = centerimageView;
    [centerView addSubview:centerimageView];
    
    [centerimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topButton.mas_bottom);
        make.width.mas_equalTo(maxBounds.size.width);
        make.bottom.equalTo(self.lastView.mas_top);
    }];
    
    [addrseeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lastView).offset(50);
        make.top.equalTo(self.lastView).offset(5);
//        make.bottom.equalTo(self.lastView).offset(-5);
        make.trailing.equalTo(self.lastView).offset(-50);
        make.height.mas_equalTo(35);
        
    }];
   
    [topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(maxBounds.size.width);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(74);
    }];
}
#pragma mark - 右边
- (void)makeTheRight{
    UITableView *right = [[UITableView alloc]initWithFrame:maxBounds style:UITableViewStyleGrouped];
    right.backgroundColor = [UIColor groupTableViewBackgroundColor];
    right.delegate = self;
    right.dataSource = self;
    [self.view addSubview:right];
    self.right = right;
    
}
#pragma mark 左右点击显示

-(void)segmentClick:(UISegmentedControl *)segment{
    
    switch (segment.selectedSegmentIndex) {
        case 0:
            //第一个界面
            self.right.hidden = YES;
            self.left.hidden = NO;
//
            self.locationLable.hidden = !self.centerImageView.hidden;
            
            break;
        case 1:
            self.right.hidden = NO;
            self.left.hidden = YES;
//
            self.locationLable.hidden = YES;
            
               break;
        default:
            break;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 3;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *first = @"first";
    static NSString *sceound = @"secoud";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:first];
    if (!cell && indexPath.section == 0) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:first];
        cell.backgroundColor = [UIColor whiteColor];
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"白石龙（地铁站）" forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter ;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIImageView *locationView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_address_locate"]];
        [cell addSubview:locationView];
        [cell addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(cell);
            make.trailing.equalTo(cell);
            make.height.equalTo(cell);
            
        }];
        [locationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.mas_top).offset(10);
            make.centerX.equalTo(cell.mas_centerX).offset(-90);
        }];
        
    }
    else if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:sceound];
        
        
        NSString *asdress;
       
        NSString *time;
        
        NSString *space;
        
        NSString *km;
        if (indexPath.row == 0) {
            asdress = @"爱鲜蜂民乐一区店 （优良汇）";
            
            time = @"营业时间9:00 -- 12:00";
            
            space = @"广东省深圳市宝安市区民乐新村167栋101";
            
            km = @"1.53km";
        }
        if (indexPath.row == 1) {
            asdress = @"爱鲜蜂峰樟坑店（家家乐）";
            
            time = @"营业时间9:00 -- 2:00";
            
            space = @"广东省深圳市宝安市区民德路";
            
            km = @"0.89km";
            
        }
        if (indexPath.row == 2) {
            asdress = @"爱鲜蜂和花园店（新日佳百货)";
            
            time = @"营业时间12:00 -- 24:00";
            
            space = @"广东省深圳市宝龙岗区";
            
            km = @"3.21km";
        }


        //左边的lable
        UILabel *lableOne = [[UILabel alloc]init];
        lableOne.font = [UIFont systemFontOfSize:15];
        lableOne.text = asdress;
        UILabel *lableTwo = [[UILabel alloc]init];
        lableTwo.textColor = [UIColor darkGrayColor];
        lableTwo.text = time;
        lableTwo.font = [UIFont systemFontOfSize:12];
        UILabel *lableThree = [[UILabel alloc]init];
        lableThree.textColor = [UIColor darkGrayColor];
        lableThree.text = space;
        lableThree.font = [UIFont systemFontOfSize:12];
        UILabel *kmLable = [[UILabel alloc]init];
        kmLable.textColor = [UIColor darkGrayColor];
        kmLable.font = [UIFont systemFontOfSize:12];

        kmLable.text = km;
        
        
        //右边的图片
        UIImageView *locationImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_mapmarker_cir"]];
        UIView *LineView = [[UIView alloc]init];
        LineView.backgroundColor = [UIColor lightGrayColor];
        
        [cell addSubview:LineView];
        [cell addSubview:locationImage];
        [cell addSubview:lableOne];
        [cell addSubview:lableTwo];
        [cell addSubview:lableThree];
        [cell addSubview:kmLable];
        
            [kmLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(locationImage.mas_bottom).offset(5);
                make.right.equalTo(cell).offset(-30);
            }];
            [lableOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(cell.contentView).offset(20);
            make.top.equalTo(cell.contentView).offset(8);
            }];
            [lableTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lableOne.mas_bottom).offset(10);
                make.leading.equalTo(cell).offset(20);
            }];
            [lableThree mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(cell).offset(20);
                make.top.equalTo(lableTwo.mas_bottom).offset(10);
            }];
            [locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell).offset(-40);
                make.top.equalTo(cell).offset(25);
            }];
        [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell).offset(-100);
            make.height.mas_equalTo(66);
            make.top.equalTo(cell).offset(10);
            make.width.mas_equalTo(2);
        }];
    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 100;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 74;
    }
    return 0;
}
#pragma mark - push 接口

- (void)didClickTheAdress:(UIButton *)sender{
  
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"DetailAddress" bundle:nil];
//    DetailAddressTableViewController *v = [sb instantiateInitialViewController];
//    [self.navigationController pushViewController:v animated:YES];
    
}

- (void)didTopButton:(UIButton *)sender{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(SureYourLocation:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.segment.hidden = YES;
    
    // ========== 加载地图视图 ==========
    MKMapView *mapview = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView = mapview;
    [self.view addSubview:mapview];
    
    // 配置代理
    [self.mapView setDelegate:self];
    
    // ========== 申请定位授权 ==========
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        
        [self.manager requestAlwaysAuthorization];
    }
    
 
    [self.mapView setShowsUserLocation:YES];
}
#pragma mark - CLLocationManager

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        
    }
}

#pragma mark - MKMapViewDelegate


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    // ========== 设置地图的显示区域 (Region) ==========
    
    // 用户所在的位置
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    self.center = center;
//    NSLog(@"%lf,%lf",center.latitude,center.longitude);
    
    // 跨度, 度数表示 (经纬度数, 1度约于111KM)
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    // 表示地图的一个区域的结构体
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    // 设置地图当前的显示区域, 带动画
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - Getter & Setter

- (CLLocationManager *)manager
{
    if (_manager == nil) {
        _manager = [[CLLocationManager alloc] init];
        
        _manager.delegate = self;
    }
    return _manager;
}
#pragma mark - 点击map上的确定键
- (void)SureYourLocation:(MKMapView *)map{
    
    
    [self.mapView removeFromSuperview];
    
    self.segment.hidden = NO;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self loctionMessage];
        
    });
    
    self.navigationItem.rightBarButtonItem = nil;
    
    [self reverseBtnAction];
    self.centerImageView.hidden = YES;
}

#pragma mark - 创建位置信息
- (void)loctionMessage{
    UILabel *lable  = [[UILabel alloc]init];
    lable.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lable.font = [UIFont systemFontOfSize:15];
    lable.lineBreakMode = NSLineBreakByCharWrapping;
    lable.numberOfLines = 0;
    self.locationLable = lable;
        [self.view addSubview:lable];
    
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topButton.mas_bottom).offset(50);
        make.leading.equalTo(self.topButton);
        
    }];
}
#pragma mark - 反地理编码
- (void)reverseBtnAction
{
//     创建一个位置, 根据指定的经纬度
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.center.latitude longitude:self.center.longitude];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *lastMark = placemarks.lastObject;
        
        self.locationLable.text = [NSString stringWithFormat:@"当前位置：%@\n当前街道：%@\n当前的城市:%@\n当前国家：%@",lastMark.name,lastMark.thoroughfare,lastMark.locality,lastMark.country];
//        self.locationLable.text = lastMark.name;
        [self.view bringSubviewToFront:self.locationLable];
       
    }];
}
#pragma mark - 实例化geoder
- (CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        _geocoder = [CLGeocoder new];
    }
    return _geocoder;
}



@end
