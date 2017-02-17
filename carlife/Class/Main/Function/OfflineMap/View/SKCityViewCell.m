//
//  SKCityViewCell.m
//  carlife
//
//  Created by Sky on 17/2/16.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKCityViewCell.h"

@implementation SKCityViewCell

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
    [self.contentView addSubview:self.sizeLabel];
    [self.contentView addSubview:self.downloadImageView];
}

- (void)subviewAttributes
{
    [self.textLabel setFont:[UIFont systemFontOfSize:14]];
    [self.sizeLabel setFont:[UIFont systemFontOfSize:14]];
    [self.sizeLabel setTextAlignment:NSTextAlignmentRight];
    [self.downloadImageView sizeToFit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.downloadImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textLabel);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    [self.sizeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textLabel);
        make.right.equalTo(self.downloadImageView.left).offset(-10);
    }];
}

#pragma mark -- 懒加载
- (UILabel *)sizeLabel
{
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc] init];
    }
    return _sizeLabel;
}
- (UIImageView *)downloadImageView
{
    if (!_downloadImageView) {
        _downloadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"download"]];
    }
    return _downloadImageView;
}
@end
