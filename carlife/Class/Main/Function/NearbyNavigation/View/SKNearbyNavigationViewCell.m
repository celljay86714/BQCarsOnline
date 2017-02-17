//
//  SKNearbyNavigationViewCell.m
//  carlife
//
//  Created by Sky on 17/2/15.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKNearbyNavigationViewCell.h"
#import "SKNearbyModel.h"

@interface SKNearbyNavigationViewCell ()

@property (nonatomic, strong) UIButton *itemButton;
@property (nonatomic, strong) UILabel *itemLabel;

@end

@implementation SKNearbyNavigationViewCell

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
    [self.contentView addSubview:self.itemButton];
    [self.contentView addSubview:self.itemLabel];
}

- (void)subviewAttributes
{
    [self.itemLabel setTextAlignment:NSTextAlignmentCenter];
    [self.itemLabel setFont:[UIFont systemFontOfSize:12]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.itemButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(self.contentView.width);
    }];
    [self.itemLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.itemButton.bottom);
    }];
}

- (void)setItem:(SKNearbyModel *)item
{
    _item = item;
    [self.itemButton setBackgroundImage:[UIImage imageNamed:item.imageName] forState:UIControlStateNormal];
    self.itemLabel.text = item.title;
}

#pragma mark -- 懒加载
- (UIButton *)itemButton
{
    if (!_itemButton) {
        _itemButton = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _itemButton;
}
- (UILabel *)itemLabel
{
    if (!_itemLabel) {
        _itemLabel = [[UILabel alloc] init];
    }
    return _itemLabel;
}

@end
