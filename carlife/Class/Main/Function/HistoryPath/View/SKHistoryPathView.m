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

@end

@implementation SKHistoryPathView

static const CGFloat btwidth = 30;
static const CGFloat labelWidth = 80;
static const CGFloat fontSize = 14;
static const CGFloat textHeight = 40;
static const CGFloat searchHeight = 40;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        [self setSubviewAttributes];
        [self didChooseTime:self.todayBt];
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
    self.todayBt.tag = 1;
    [self.todayBt addTarget:self action:@selector(didChooseTime:) forControlEvents:UIControlEventTouchUpInside];
    self.todayLabel.text = @"今天";
    [self.todayLabel setFont:[UIFont systemFontOfSize:fontSize]];
    
    [self.yesterdayBt setBackgroundImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    self.yesterdayBt.tag = 2;
    [self.yesterdayBt addTarget:self action:@selector(didChooseTime:) forControlEvents:UIControlEventTouchUpInside];
    self.yesterdayLabel.text = @"昨天";
    [self.yesterdayLabel setFont:[UIFont systemFontOfSize:fontSize]];
    
    [self.customBt setBackgroundImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    self.customBt.tag = 3;
    [self.customBt addTarget:self action:@selector(didChooseTime:) forControlEvents:UIControlEventTouchUpInside];
    self.customLabel.text = @"自定义";
    [self.customLabel setFont:[UIFont systemFontOfSize:fontSize]];
    
    [self.fromTextField setTextAlignment:NSTextAlignmentCenter];
    [self.toTextField setTextAlignment:NSTextAlignmentCenter];
    [self.fromTextField setBorderStyle:UITextBorderStyleLine];
    [self.toTextField setBorderStyle:UITextBorderStyleLine];
    
    [self.searchBt setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBt setBackgroundColor:[UIColor orangeColor]];
    [self.searchBt.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.searchBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


/**
 选择时间

 @param button
 */
- (void)didChooseTime:(UIButton *)button
{
//    self.selectDate(button.tag);
    [self.todayBt setBackgroundImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    [self.yesterdayBt setBackgroundImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    [self.customBt setBackgroundImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateNormal];
    
    NSDate *now = [NSDate date];
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-60*60*24];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *nowStr = [formatter stringFromDate:now];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *todayStr = [formatter stringFromDate:now];
    NSString *tdStart = [NSString stringWithFormat:@"%@ 00:00",todayStr];
    NSString *yesterdayStr = [formatter stringFromDate:yesterday];
    NSString *ydStart = [NSString stringWithFormat:@"%@ 00:00",yesterdayStr];
    NSString *ydEnd = [NSString stringWithFormat:@"%@ 23:59",yesterdayStr];
    
    switch (button.tag) {
        case 1:
            self.fromTextField.text = tdStart;
            self.toTextField.text = nowStr;
            [self.toTextField setEnabled:NO];
            [self.fromTextField setEnabled:NO];
            break;
        case 2:
            self.fromTextField.text = ydStart;
            self.toTextField.text = ydEnd;
            [self.toTextField setEnabled:NO];
            [self.fromTextField setEnabled:NO];
            break;
            
        default:
            [self.toTextField setEnabled:YES];
            [self.fromTextField setEnabled:YES];
            break;
    }
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
