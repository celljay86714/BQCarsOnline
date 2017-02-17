//
//  SKHomeViewCell.h
//  carlife
//
//  Created by Sky on 17/2/9.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SKHomeModel;

@interface SKHomeViewCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *itemButton;
@property (nonatomic, strong) UILabel *itemLabel;

@property (nonatomic, strong) SKHomeModel *item;

@property (nonatomic, copy) void (^clickItem)();

@end
