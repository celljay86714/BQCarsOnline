//
//  SKOfflineMapView.m
//  carlife
//
//  Created by Sky on 17/2/15.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKOfflineMapView.h"

@interface SKOfflineMapView ()

@property (nonatomic, strong) UISegmentedControl *segmentControl;

@end

@implementation SKOfflineMapView

static const CGFloat segmentHeight = 36;
static const CGFloat margin = 5;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubviews];
        [self subviewAttributes];
    }
    return self;
}

- (void)setSubviews
{
    [self addSubview:self.segmentControl];
    [self addSubview:self.cityView];
    [self addSubview:self.downloadView];
}

- (void)subviewAttributes
{
    self.segmentControl.tintColor = [UIColor orangeColor];
    [self.segmentControl setSelectedSegmentIndex:0];
    [self.segmentControl addTarget:self action:@selector(didChange) forControlEvents:UIControlEventValueChanged];
    
    self.cityView.tag = cityViewTag;
    self.downloadView.tag = downloadViewTag;
    self.downloadView.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.segmentControl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.centerX.equalTo(self);
        make.height.equalTo(segmentHeight);
    }];
}

- (void)didChange
{
    self.segmentChange(self.segmentControl.selectedSegmentIndex);
}

#pragma mark -- 懒加载
- (UISegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"城市列表",@"下载管理", nil]];
    }
    return _segmentControl;
}
- (UITableView *)cityView
{
    if (!_cityView) {
        _cityView = [[UITableView alloc] initWithFrame:CGRectMake(0, segmentHeight+margin, self.bounds.size.width, self.bounds.size.height-segmentHeight-margin) style:UITableViewStylePlain];
    }
    return _cityView;
}
- (UITableView *)downloadView
{
    if (!_downloadView) {
        _downloadView = [[UITableView alloc] initWithFrame:CGRectMake(0, segmentHeight+margin, self.bounds.size.width, self.bounds.size.height-segmentHeight-margin) style:UITableViewStylePlain];
    }
    return _downloadView;
}

@end
