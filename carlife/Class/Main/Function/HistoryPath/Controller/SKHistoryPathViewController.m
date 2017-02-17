//
//  SKHistoryPathViewController.m
//  carlife
//
//  Created by Sky on 17/2/14.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKHistoryPathViewController.h"
#import "SKHistoryPathView.h"

@interface SKHistoryPathViewController ()

@property (nonatomic, strong) SKHistoryPathView *pathView;

@end

@implementation SKHistoryPathViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"历史轨迹";
    self.view = self.pathView;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (SKHistoryPathView *)pathView
{
    if (!_pathView) {
        _pathView = [[SKHistoryPathView alloc] initWithFrame:self.view.bounds];
    }
    return _pathView;
}
@end
