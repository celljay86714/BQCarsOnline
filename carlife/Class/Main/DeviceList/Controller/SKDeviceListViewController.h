//
//  SKDeviceListViewController.h
//  carlife
//
//  Created by Sky on 17/2/8.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKBaseViewController.h"

@interface SKDeviceListViewController : SKBaseViewController

@property (nonatomic, strong) UITableView *allTableView;
@property (nonatomic, strong) UITableView *onlineTableView;
@property (nonatomic, strong) UITableView *offTableView;

@end
