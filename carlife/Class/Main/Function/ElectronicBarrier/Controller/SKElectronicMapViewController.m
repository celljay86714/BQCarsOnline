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

@property (nonatomic, strong) BMKAnnotationView *annotationView;
@property (nonatomic, strong) BMKPointAnnotation *pointAnnotation;

@property (nonatomic, strong) BMKCircle *circle;
@property (nonatomic, assign) NSInteger radius;
@end

@implementation SKElectronicMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"电子栅栏";
    [self.view insertSubview:self.mapView atIndex:0];
    [self.mapView setZoomLevel:15];
    self.radius = 100;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.locService.delegate = self;
    self.searcher.delegate = self;
    
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
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;
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
- (BMKPointAnnotation *)pointAnnotation
{
    if (!_pointAnnotation) {
        _pointAnnotation = [[BMKPointAnnotation alloc] init];
    }
    return _pointAnnotation;
}

#pragma mark -- mapview代理
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    //系统自带
    mapView.showMapScaleBar = YES;
    mapView.mapScaleBarPosition = CGPointMake(mapView.bounds.size.width-mapView.mapScaleBarSize.width-15, 10);
    CLLocationCoordinate2D coor;
    coor.latitude = 43.84038;
    coor.longitude = 87.564988;
    [self.mapView setCenterCoordinate:coor animated:YES];
    self.pointAnnotation.coordinate = coor;
    [self.mapView addAnnotation:self.pointAnnotation];
    
    //定位
    [self startLocation];
}
//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKCircle class]])
    {
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:0.5];
        circleView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.5];
        circleView.lineWidth = 5.0;
        
        return circleView;
    }

    return nil;
}
// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if (!self.annotationView) {
        self.annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"anonationID"];
        //直接显示,不用点击弹出
        [self.annotationView setSelected:YES];
        self.annotationView.image = [UIImage imageNamed:@"online_0"];
        UIView *popView = [[[NSBundle mainBundle] loadNibNamed:@"PopView" owner:nil options:nil] lastObject];
        popView.backgroundColor = [UIColor clearColor];
        BMKActionPaopaoView *paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:popView];
        self.annotationView.paopaoView = paopaoView;
    }
    return self.annotationView;
}
- (void)mapStatusDidChanged:(BMKMapView *)mapView
{
    CLLocationCoordinate2D coor = mapView.centerCoordinate;
    // 添加圆形覆盖物
    self.circle = [BMKCircle circleWithCenterCoordinate:coor radius:self.radius];
    [self.mapView removeOverlay:self.circle];
    [self.mapView addOverlay:self.circle];
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
