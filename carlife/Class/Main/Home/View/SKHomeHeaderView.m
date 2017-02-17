//
//  SKHomeHeaderView.m
//  carlife
//
//  Created by Sky on 17/2/9.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKHomeHeaderView.h"

@interface SKHomeHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SKHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setHeaderView];
    }
    return self;
}

- (void)setHeaderView
{
    [self addSubview:self.imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dashboard"]];
    }
    return _imageView;
}

@end
