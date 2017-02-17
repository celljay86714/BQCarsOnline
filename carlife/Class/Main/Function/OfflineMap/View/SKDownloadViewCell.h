//
//  SKDownloadViewCell.h
//  carlife
//
//  Created by Sky on 17/2/16.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKDownloadViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *downloadBt;
@property (nonatomic, strong) UIButton *deleteBt;

@property (nonatomic, copy) void (^deleteCity)();
@end
