//
//  SKRealTimeLocationViewController.h
//  carlife
//
//  Created by Sky on 17/2/13.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKBaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKGeoCodeSearch.h>

@interface SKRealTimeLocationViewController : SKBaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKGeoCodeSearch *searcher;

@end
