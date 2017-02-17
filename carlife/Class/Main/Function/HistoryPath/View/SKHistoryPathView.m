//
//  SKHistoryPathView.m
//  carlife
//
//  Created by Sky on 17/2/14.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKHistoryPathView.h"

@interface SKHistoryPathView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *todayBt;
@property (nonatomic, strong) UIButton *yesterdayBt;
@property (nonatomic, strong) UIButton *customBt;

@property (nonatomic, strong) UILabel *todayLabel;
@property (nonatomic, strong) UILabel *yesterdayLabel;
@property (nonatomic, strong) UILabel *customLabel;

@property (nonatomic, strong) UITextField *fromTextField;
@property (nonatomic, strong) UITextField *toTextField;

@property (nonatomic, strong) UIButton *searchBt;

@end

@implementation SKHistoryPathView

static const CGFloat btwidth = 20;
static const CGFloat labelWidth = 80;
static const CGFloat fontSize = 13;
static const CGFloat textHeight = 30;
static const CGFloat searchHeight = 36;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        [self setSubviewAttributes];
    }
    return self;
}

- (void)setupSubviews
{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.todayBt];
    [self.contentView addSubview:self.yesterdayBt];
    [self.contentView addSubview:self.customBt];
    [self.contentView addSubview:self.todayLabel];
    [self.contentView addSubview:self.yesterdayLabel];
    [self.contentView addSubview:self.customLabel];
    [self.contentView addSubview:self.fromTextField];
    [self.contentView addSubview:self.toTextField];
    [self.contentView addSubview:self.searchBt];
}

- (void)setSubviewAttributes
{
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self.todayBt setBackgroundImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateNormal];
    self.todayLabel.text = @"今天";
    [self.todayLabel setFont:[UIFont systemFontOfSize:fontSize]];
    
    [self.yesterdayBt setBackgroundImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    self.yesterdayLabel.text = @"昨天";
    [self.yesterdayLabel setFont:[UIFont systemFontOfSize:fontSize]];
    
    [self.customBt setBackgroundImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    self.customLabel.text = @"自定义";
    [self.customLabel setFont:[UIFont systemFontOfSize:fontSize]];
    
    [self.fromTextField setPlaceholder:@"2017/02/15 00:00"];
    [self.toTextField setPlaceholder:@"2017/02/15 09:10"];
    [self.fromTextField setTextAlignment:NSTextAlignmentCenter];
    [self.toTextField setTextAlignment:NSTextAlignmentCenter];
    [self.fromTextField setBorderStyle:UITextBorderStyleLine];
    [self.toTextField setBorderStyle:UITextBorderStyleLine];
    [self.fromTextField setEnabled:NO];
    [self.toTextField setEnabled:NO];
    
    [self.searchBt setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBt setBackgroundColor:[UIColor orangeColor]];
    [self.searchBt.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.searchBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(TopBarHeight);
        make.left.equalTo(self).offset(20);
        make.height.equalTo(300);
    }];
    [self.todayBt makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.width.height.equalTo(btwidth);
        make.top.equalTo(self.contentView).offset(25);
    }];
    [self.todayLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.todayBt.right).offset(2);
        make.centerY.equalTo(self.todayBt);
        make.width.equalTo(labelWidth);
    }];
    [self.yesterdayBt makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.todayLabel.right);
        make.width.height.equalTo(btwidth);
        make.centerY.equalTo(self.todayBt);
    }];
    [self.yesterdayLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yesterdayBt.right).offset(2);
        make.centerY.equalTo(self.todayBt);
        make.width.equalTo(labelWidth);
    }];
    [self.customBt makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yesterdayLabel.right);
        make.width.height.equalTo(btwidth);
        make.centerY.equalTo(self.todayBt);
    }];
    [self.customLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.customBt.right).offset(2);
        make.centerY.equalTo(self.todayBt);
        make.width.equalTo(labelWidth);
    }];
    [self.fromTextField makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.contentView);
        make.top.equalTo(self.todayBt.bottom).offset(5);
        make.height.equalTo(textHeight);
    }];
    [self.toTextField makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.contentView);
        make.top.equalTo(self.fromTextField.bottom).offset(8);
        make.height.equalTo(textHeight);
    }];
    [self.searchBt makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toTextField.bottom).offset(10);
        make.width.centerX.equalTo(self.contentView);
        make.height.equalTo(searchHeight);
    }];
}

#pragma mark -- 懒加载
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}
- (UIButton *)todayBt
{
    if (!_todayBt) {
        _todayBt = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _todayBt;
}
- (UIButton *)yesterdayBt
{
    if (!_yesterdayBt) {
        _yesterdayBt = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _yesterdayBt;
}
- (UIButton *)customBt
{
    if (!_customBt) {
        _customBt = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _customBt;
}
- (UILabel *)todayLabel
{
    if (!_todayLabel) {
        _todayLabel = [[UILabel alloc] init];
    }
    return _todayLabel;
}
- (UILabel *)yesterdayLabel
{
    if (!_yesterdayLabel) {
        _yesterdayLabel = [[UILabel alloc] init];
    }
    return _yesterdayLabel;
}
- (UILabel *)customLabel
{
    if (!_customLabel) {
        _customLabel = [[UILabel alloc] init];
    }
    return _customLabel;
}
- (UITextField *)fromTextField
{
    if (!_fromTextField) {
        _fromTextField = [[UITextField alloc] init];
    }
    return _fromTextField;
}
- (UITextField *)toTextField
{
    if (!_toTextField) {
        _toTextField = [[UITextField alloc] init];
    }
    return _toTextField;
}
- (UIButton *)searchBt
{
    if (!_searchBt) {
        _searchBt = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _searchBt;
}
@end
