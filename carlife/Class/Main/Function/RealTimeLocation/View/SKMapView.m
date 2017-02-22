//
//  SKMapView.m
//  carlife
//
//  Created by Sky on 17/2/20.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKMapView.h"

@implementation SKMapView

static const NSInteger rightMargin = 14;
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setAttributes];
        [self setSubviews];
        [self subviewAttributes];
    }
    return self;
}

- (void)setAttributes
{
    [self setZoomLevel:15];
}

- (void)setSubviews
{
    [self addSubview:self.headView];
    [self.headView addSubview: self.headLabel];
    [self addSubview:self.distanceImageView];
    [self.distanceImageView addSubview:self.distanceLabel];
    [self addSubview:self.mapTypeBt];
    [self addSubview:self.locationTypeBt];
    [self addSubview:self.navigationBt];
    [self addSubview:self.zoomInBt];
    [self addSubview:self.zoomOutBt];
}

- (void)subviewAttributes
{
    [self.headView setBackgroundColor:[UIColor whiteColor]];
    [self.headLabel setFont:SYSTEMFONT(14)];
    self.headLabel.text = @"新疆维吾尔族自治区乌鲁木齐市192米";
    [self.distanceLabel setFont:SYSTEMFONT(13)];
    self.distanceLabel.text = @"人车相距1832km";
    
    [self.mapTypeBt setBackgroundImage:[UIImage imageNamed:@"map_type_satelite"] forState:UIControlStateNormal];
    [self.navigationBt setBackgroundImage:[UIImage imageNamed:@"location_carandperson"] forState:UIControlStateNormal];
    [self.locationTypeBt setBackgroundImage:[UIImage imageNamed:@"location_normal"] forState:UIControlStateNormal];
    [self.zoomOutBt setBackgroundImage:[UIImage imageNamed:@"zoomout_normal"] forState:UIControlStateNormal];
    [self.zoomInBt setBackgroundImage:[UIImage imageNamed:@"zoomin_normal"] forState:UIControlStateNormal];
    
    [self.zoomOutBt sizeToFit];
    [self.zoomInBt sizeToFit];
    
    //系统自带
    self.showMapScaleBar = YES;
    self.mapScaleBarPosition = CGPointMake(self.bounds.size.width-self.mapScaleBarSize.width-rightMargin, self.headView.frame.size.height+rightMargin/2);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.headLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView).offset(5);
        make.top.equalTo(self.headView).offset(8);
    }];
    
    [self.mapTypeBt makeConstraints:^(MASConstraintMaker *make) {
        CGFloat topM = self.mapScaleBarPosition.y+self.mapScaleBarSize.height;
        make.top.equalTo(self).offset(topM);
        make.left.equalTo(self).offset(self.mapScaleBarPosition.x);
        make.width.height.equalTo(self.mapScaleBarSize.width);
    }];
    
    [self.locationTypeBt makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-rightMargin);
        make.left.equalTo(self).offset(rightMargin);
        make.width.height.equalTo(50);
    }];
    [self.navigationBt makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.locationTypeBt.top).offset(-rightMargin);
        make.left.equalTo(self.locationTypeBt);
        make.width.height.equalTo(self.locationTypeBt);
    }];
    
    [self.distanceImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.locationTypeBt);
        make.width.equalTo(100);
        make.height.equalTo(40);
    }];
    [self.distanceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.distanceImageView);
    }];
    
    [self.zoomOutBt makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.locationTypeBt);
        make.right.equalTo(self.mapTypeBt);
    }];
    [self.zoomInBt makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.zoomOutBt);
        make.bottom.equalTo(self.zoomOutBt.top);
    }];
}

#pragma mark -- 懒加载
- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
    }
    return _headView;
}
- (UILabel *)headLabel
{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc] init];
    }
    return _headLabel;
}
- (UIImageView *)distanceImageView
{
    if (!_distanceImageView) {
        _distanceImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map_alert_bg"]];
    }
    return _distanceImageView;
}
- (UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] init];
    }
    return _distanceLabel;
}
- (UIButton *)mapTypeBt
{
    if (!_mapTypeBt) {
        _mapTypeBt = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _mapTypeBt;
}
- (UIButton *)navigationBt
{
    if (!_navigationBt) {
        _navigationBt = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _navigationBt;
}
- (UIButton *)locationTypeBt
{
    if (!_locationTypeBt) {
        _locationTypeBt = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _locationTypeBt;
}
- (UIButton *)zoomInBt
{
    if (!_zoomInBt) {
        _zoomInBt = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _zoomInBt;
}
- (UIButton *)zoomOutBt
{
    if (!_zoomOutBt) {
        _zoomOutBt = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _zoomOutBt;
}

@end
