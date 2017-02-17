//
//  SKDownloadViewCell.m
//  carlife
//
//  Created by Sky on 17/2/16.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKDownloadViewCell.h"

@implementation SKDownloadViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubviews];
        [self subviewAttributes];
    }
    return self;
}

- (void)setSubviews
{
    [self.contentView addSubview:self.downloadBt];
    [self.contentView addSubview:self.deleteBt];
}

- (void)subviewAttributes
{
    [self.textLabel setFont:SYSTEMFONT(14)];
    
    [self.downloadBt setTitle:@"暂停" forState:UIControlStateNormal];
    [self.downloadBt setTintColor:[UIColor orangeColor]];
    [self.downloadBt.titleLabel setFont:BOLDSYSTEMFONT(14)];
    [self.downloadBt sizeToFit];
    
    [self.deleteBt setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBt setTintColor:[UIColor orangeColor]];
    [self.deleteBt.titleLabel setFont:BOLDSYSTEMFONT(14)];
    [self.deleteBt sizeToFit];
    [self.deleteBt addTarget:self action:@selector(didClickDeleteBt) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClickDeleteBt
{
    self.deleteCity();
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.deleteBt makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textLabel);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    [self.downloadBt makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textLabel);
        make.right.equalTo(self.deleteBt.left).offset(-18);
    }];
}

#pragma mark -- 懒加载
- (UIButton *)downloadBt
{
    if (!_downloadBt) {
        _downloadBt = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _downloadBt;
}
- (UIButton *)deleteBt
{
    if (!_deleteBt) {
        _deleteBt = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _deleteBt;
}

@end
