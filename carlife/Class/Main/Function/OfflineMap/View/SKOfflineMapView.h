//
//  SKOfflineMapView.h
//  carlife
//
//  Created by Sky on 17/2/15.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#define cityViewTag 1001
#define downloadViewTag 1002

@interface SKOfflineMapView : UIView

@property (nonatomic, strong) UITableView *cityView;
@property (nonatomic, strong) UITableView *downloadView;

@property (nonatomic, copy) void (^segmentChange)(NSInteger);
@end
