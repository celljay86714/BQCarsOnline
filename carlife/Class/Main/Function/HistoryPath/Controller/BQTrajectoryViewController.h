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
