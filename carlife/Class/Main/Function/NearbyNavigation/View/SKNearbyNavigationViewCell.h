//
//  SKNearbyNavigationViewCell.h
//  carlife
//
//  Created by Sky on 17/2/15.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SKNearbyModel;

@interface SKNearbyNavigationViewCell : UICollectionViewCell

@property (nonatomic, strong) SKNearbyModel *item;

@property (nonatomic, copy) void (^clickItem)();

@end
