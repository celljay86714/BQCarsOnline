//
//  SKNearbyNavigationViewController.m
//  carlife
//
//  Created by Sky on 17/2/15.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKNearbyNavigationViewController.h"
#import "SKNearbyViewFlowLayout.h"
#import "SKNearbyNavigationViewCell.h"
#import "SKNearbyModel.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@interface SKNearbyNavigationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *nearbyView;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation SKNearbyNavigationViewController

static NSString *cellID = @"nearbyCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"周边导航";
    [self.view addSubview:self.nearbyView];
    self.nearbyView.backgroundColor = [UIColor whiteColor];
    
    [self.nearbyView registerClass:[SKNearbyNavigationViewCell class] forCellWithReuseIdentifier:cellID];
    self.nearbyView.delegate = self;
    self.nearbyView.dataSource = self;
}

#pragma mark -- 懒加载
- (UICollectionView *)nearbyView
{
    if (!_nearbyView) {
        _nearbyView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[SKNearbyViewFlowLayout alloc] init]];
    }
    return _nearbyView;
}
- (NSMutableArray *)items
{
    if (!_items) {
        [SKNearbyModel loadItems:^(NSArray *items) {
            _items = [NSMutableArray arrayWithArray:items];
        }];
    }
    return _items;
}

#pragma mark -- UICollectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SKNearbyNavigationViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.item = self.items[indexPath.item];
    NSString *keyword = cell.item.title;
    cell.clickItem = ^{
        BMKOpenPoiNearbyOption *opt = [[BMKOpenPoiNearbyOption alloc] init];
        opt.appScheme = @"baidumapsdk://mapsdk.baidu.com";
        opt.keyword = keyword;
        opt.location = CLLocationCoordinate2DMake(39.915, 116.360582);
        opt.radius = 1000;
        BMKOpenErrorCode code = [BMKOpenPoi openBaiduMapPoiNearbySearch:opt];
    };
    return cell;
}

@end
