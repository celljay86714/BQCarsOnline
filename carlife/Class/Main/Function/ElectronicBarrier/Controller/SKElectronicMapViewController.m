//
//  SKElectronicMapViewController.m
//  carlife
//
//  Created by Sky on 2017/2/23.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKElectronicMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKGeoCodeSearch.h>

@interface SKElectronicMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKGeoCodeSearch *searcher;

@end

@implementation SKElectronicMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"电子栅栏";
    //适配ios7
    if(isIOS7)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    self.view = self.mapView;
    
    //系统自带
    self.mapView.showMapScaleBar = YES;
    self.mapView.mapScaleBarPosition = CGPointMake(self.view.bounds.size.width-self.mapView.mapScaleBarSize.width-15, 10);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.locService.delegate = self;
    self.searcher.delegate = self;
    
    //设置我的位置(原来是蓝点的位置)的样式
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
    //不显示精度圈
    param.isAccuracyCircleShow = YES;
    //    param.locationViewImgName = @"newMyLocationImage";
    [self.mapView updateLocationViewWithParam:param];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    self.locService.delegate = nil;
    self.searcher.delegate = nil;
}

- (void)startLocation
{
    NSLog(@"进入方向定位态");
    [self.locService startUserLocationService];
    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode = BMKUserTrackingModeHeading;
    self.mapView.showsUserLocation = YES;
}

#pragma mark -- 懒加载
- (BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    }
    return _mapView;
}
- (BMKLocationService *)locService
{
    if (!_locService) {
        _locService = [[BMKLocationService alloc] init];
        //设定定位精度
        _locService.desiredAccuracy = kCLLocationAccuracyBest;
        _locService.distanceFilter = 10;
    }
    return _locService;
}
- (BMKGeoCodeSearch *)searcher
{
    if (!_searcher) {
        _searcher = [[BMKGeoCodeSearch alloc] init];
    }
    return _searcher;
}

#pragma mark -- mapview代理
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    [self startLocation];
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(43.84038, 87.564988) animated:YES];
}
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    return nil;
}

#pragma mark -- BMKLocation代理
- (void)willStartLocatingUser
{
    
}
- (void)didStopLocatingUser
{
    
}
- (void)didFailToLocateUserWithError:(NSError *)error
{
    
}
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
    
}

- (void)dealloc {
    if (self.mapView) {
        self.mapView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
