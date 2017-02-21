//
//  SKRealTimeLocationViewController.m
//  carlife
//
//  Created by Sky on 17/2/13.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKRealTimeLocationViewController.h"

@interface SKRealTimeLocationViewController ()

@property (nonatomic, strong) BMKPolyline *polyline;

@end

@implementation SKRealTimeLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"实时跟踪";
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    self.view = self.mapView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.locService.delegate = self;
    self.searcher.delegate = self;
    
    //设置我的位置(原来是蓝点的位置)的样式
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
    //不显示精度圈
    param.isAccuracyCircleShow = NO;
//    param.locationViewImgName = @"newMyLocationImage";
    [self.mapView updateLocationViewWithParam:param];
}

- (void)viewWillDisappear:(BOOL)animated
{
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
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;
    self.mapView.showsUserLocation = YES;
}

//两点划线
- (void)lineWithUserLocation:(BMKUserLocation *)userLocation
{
    CLLocationCoordinate2D coor[2] = {0};
    coor[0].latitude = userLocation.location.coordinate.latitude;
    coor[0].longitude = userLocation.location.coordinate.longitude;
    coor[1].latitude = 43.84038;
    coor[1].longitude = 87.564988;
    self.polyline = [BMKPolyline polylineWithCoordinates:coor count:2];
    [self.mapView addOverlay:self.polyline];
}

#pragma mark -- 懒加载
- (SKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[SKMapView alloc] initWithFrame:self.view.bounds];
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
- (BMKPolyline *)polyline
{
    if (!_polyline) {
        _polyline = [[BMKPolyline alloc] init];
    }
    return _polyline;
}

#pragma mark -- mapview代理
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    [self startLocation];
}
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor greenColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 3;
        return polylineView;
    }
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
    [_mapView updateLocationData:userLocation];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    //87.564988,43.84038
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(43.84038, 87.564988) animated:YES];
    [self lineWithUserLocation:userLocation];
}


- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

@end
