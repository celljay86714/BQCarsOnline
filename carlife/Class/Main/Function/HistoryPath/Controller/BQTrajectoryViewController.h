//
//  BQTrajectoryViewController.h
//  carlife
//
//  Created by jer on 2017/2/22.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface BQTrajectoryViewController : UIViewController<BMKMapViewDelegate>

@property (strong, nonatomic)BMKMapView *mapView;

@end


// 自定义BMKAnnotationView，用于显示运动者
@interface SportAnnotationView : BMKAnnotationView

@property (nonatomic, strong) UIImageView *imageView;

@end


// 运动结点信息类
@interface BMKSportNode : NSObject

//经纬度
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
//方向（角度）
@property (nonatomic, assign) CGFloat angle;
//距离
@property (nonatomic, assign) CGFloat distance;
//速度
@property (nonatomic, assign) CGFloat speed;

@end
