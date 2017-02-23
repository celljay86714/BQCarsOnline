//
//  SKHomeHeaderView.m
//  carlife
//
//  Created by Sky on 17/2/9.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKHomeHeaderView.h"
#import "UIView+Rotatable.h"

@interface SKHomeHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,strong) UIView * animationView;

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

-(void)setlayer{
    
    self.animationView =[[UIView alloc]init];
    self.animationView.frame =CGRectMake(self.frame.size.width/2-5, 74, 4, 108);
    self.animationView.backgroundColor =[UIColor whiteColor];
    [self addSubview:self.animationView];
    
    [self.animationView setAngle:360 animated:YES];
    
    
}

@end
