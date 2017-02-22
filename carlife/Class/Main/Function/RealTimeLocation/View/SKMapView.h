//
//  SKMapView.h
//  carlife
//
//  Created by Sky on 17/2/20.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface SKMapView : BMKMapView

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *distanceImageView;

@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UILabel *distanceLabel;

@property (nonatomic, strong) UIButton *mapTypeBt;
@property (nonatomic, strong) UIButton *navigationBt;
@property (nonatomic, strong) UIButton *locationTypeBt;
@property (nonatomic, strong) UIButton *zoomOutBt;//缩小
@property (nonatomic, strong) UIButton *zoomInBt;//放大

@end
