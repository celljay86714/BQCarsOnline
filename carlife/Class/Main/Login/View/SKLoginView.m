//
//  SKLoginView.m
//  carlife
//
//  Created by Sky on 17/1/11.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKLoginView.h"
#import "SKLoginOptionViewCell.h"

#define buttonTitleColor DEFAULT_COLOR
#define buttonTitleFont [UIFont systemFontOfSize:15 weight:0]

@interface SKLoginView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *loginTypeLabel;
@property (nonatomic, weak) UILabel *accountLabel;
@property (nonatomic, weak) UILabel *pwdLabel;
@property (nonatomic, weak) UILabel *mapLabel;
@property (nonatomic, weak) UILabel *rememberLoginLabel;

@property (nonatomic, weak) UIView *loginBodyView;
@property (nonatomic, weak) UIView *loginTypeView;
@property (nonatomic, weak) UIView *accountView;
@property (nonatomic, weak) UIView *pwdView;
@property (nonatomic, weak) UIView *mapView;

@property (nonatomic, weak) UIButton *loginTypeButton;
@property (nonatomic, weak) UIButton *loginDeviceButton;
@property (nonatomic, weak) UIButton *loginPlateButton;
@property (nonatomic, weak) UIButton *mapTypeButton;
@property (nonatomic, weak) UIButton *baiduMapButton;
@property (nonatomic, weak) UIButton *gaodeMapButton;
@property (nonatomic, weak) UIButton *loginButton;

@property (nonatomic, weak) UITableView *loginTypeOptionView;
@property (nonatomic, weak) UITableView *mapTypeOptionView;

@property (nonatomic, weak) UITextField *accountField;
@property (nonatomic, weak) UITextField *pwdField;

@property (nonatomic, weak) UISwitch *rememberLoginSwitch;

@end

@implementation SKLoginView

- (instancetype)init
{
    if (self = [super init] ) {
        [self setSubviews];
        [self setAttributes];
    }
    return self;
}

- (void)setSubviews
{
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIView *loginBodyView = [[UIView alloc] init];
    [self addSubview:loginBodyView];
    self.loginBodyView = loginBodyView;
    
    
    
    UIView *loginTypeView = [[UIView alloc] init];
    UILabel *loginTypeLabel = [[UILabel alloc] init];
    [loginTypeView addSubview:loginTypeLabel];
    [self.loginBodyView addSubview:loginTypeView];
    self.loginTypeLabel = loginTypeLabel;
    self.loginTypeView = loginTypeView;
    
    UILabel *accountLabel = [[UILabel alloc] init];
    UIView *accountView = [[UIView alloc] init];
    [accountView addSubview:accountLabel];
    [self.loginBodyView addSubview:accountView];
    self.accountView = accountView;
    self.accountLabel = accountLabel;
    
    UILabel *pwdLabel = [[UILabel alloc] init];
    UIView *pwdView = [[UIView alloc] init];
    [pwdView addSubview:pwdLabel];
    [self.loginBodyView addSubview:pwdView];
    self.pwdView = pwdView;
    self.pwdLabel = pwdLabel;
    
    UILabel *mapLabel = [[UILabel alloc] init];
    UIView *mapView = [[UIView alloc] init];
    [mapView addSubview:mapLabel];
    [self.loginBodyView addSubview:mapView];
    self.mapView = mapView;
    self.mapLabel = mapLabel;
    
    UIButton *loginTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBodyView addSubview:loginTypeButton];
    self.loginTypeButton = loginTypeButton;

    UIButton *mapTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBodyView addSubview:mapTypeButton];
    self.mapTypeButton = mapTypeButton;
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.loginBodyView addSubview:loginButton];
    self.loginButton = loginButton;
    
    UITableView *loginTypeOptionView = [[UITableView alloc] init];
    [self.loginBodyView addSubview:loginTypeOptionView];
    self.loginTypeOptionView = loginTypeOptionView;
    
    UITableView *mapTypeOptionView = [[UITableView alloc] init];
    [self.loginBodyView addSubview:mapTypeOptionView];
    self.mapTypeOptionView = mapTypeOptionView;
    
    UITextField *accountField = [[UITextField alloc] init];
    [self.loginBodyView addSubview:accountField];
    self.accountField = accountField;
    
    UITextField *pwdField = [[UITextField alloc] init];
    [self.loginBodyView addSubview:pwdField];
    self.pwdField = pwdField;
    
    UISwitch *rememberLoginSwitch = [[UISwitch alloc] init];
    [self.loginBodyView addSubview:rememberLoginSwitch];
    self.rememberLoginSwitch = rememberLoginSwitch;
    
    UILabel *rememberLoginLabel = [[UILabel alloc] init];
    [self.loginBodyView addSubview:rememberLoginLabel];
    self.rememberLoginLabel = rememberLoginLabel;
}

- (void)setAttributes
{
    [self.titleLabel setFont:[UIFont systemFontOfSize:36 weight:0]];
    self.titleLabel.text = @"爱车在哪";
    
    [self setLabelViewAttributes];
    [self setButtonFieldAttributes];
    [self setOptionViewAttributes:self.loginTypeOptionView tag:1];
    [self setOptionViewAttributes:self.mapTypeOptionView tag:2];
    
    self.rememberLoginLabel.text = @"记住登录信息";
    [self.rememberLoginLabel setFont:[UIFont systemFontOfSize:14 weight:0]];
    
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setBackgroundColor:DEFAULT_COLOR];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton.titleLabel setFont:[UIFont systemFontOfSize:18 weight:1]];
}

- (void)setOptionViewAttributes:(UITableView *)optionView tag:(NSInteger)tag
{
    optionView.delegate = self;
    optionView.dataSource = self;
    optionView.tag = tag;
    [optionView setHidden:YES];
}

- (void)setLabelViewAttributes
{
    UIColor *labelViewColor = DEFAULT_COLOR;
    UIColor *labelColor = [UIColor whiteColor];
    UIFont *labelFont = [UIFont systemFontOfSize:14 weight:1];
    
    [self.loginTypeView setBackgroundColor:labelViewColor];
    self.loginTypeLabel.text = @"登录方式";
    [self.loginTypeLabel setFont:labelFont];
    [self.loginTypeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.loginTypeLabel setTextColor:labelColor];
    
    [self.accountView setBackgroundColor:labelViewColor];
    self.accountLabel.text = @"账号";
    [self.accountLabel setFont:labelFont];
    [self.accountLabel setTextAlignment:NSTextAlignmentJustified];
    [self.accountLabel setTextColor:labelColor];
    
    [self.pwdView setBackgroundColor:labelViewColor];
    self.pwdLabel.text = @"密码";
    [self.pwdLabel setFont:labelFont];
    [self.pwdLabel setTextAlignment:NSTextAlignmentJustified];
    [self.pwdLabel setTextColor:labelColor];
    
    [self.mapView setBackgroundColor:labelViewColor];
    self.mapLabel.text = @"选择地图";
    [self.mapLabel setFont:labelFont];
    [self.mapLabel setTextAlignment:NSTextAlignmentCenter];
    [self.mapLabel setTextColor:labelColor];
    
    [self.rememberLoginSwitch setOn:YES];
}

- (void)setButtonFieldAttributes
{
    [self setButtonStyle:self.loginTypeButton title:@"设备号或车牌号" andPadding:10];
    [self setButtonStyle:self.mapTypeButton title:@"地图类型" andPadding:10];
    
    [self.accountField setPlaceholder:@"请输入设备号或车牌号"];
    [self.accountField setBorderStyle:UITextBorderStyleBezel];
    [self.accountField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.accountField setReturnKeyType:UIReturnKeyDone];
    self.accountField.delegate = self;
    
    [self.pwdField setPlaceholder:@"请输入密码"];
    [self.pwdField setSecureTextEntry:YES];
    [self.pwdField setBorderStyle:UITextBorderStyleBezel];
    [self.pwdField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.pwdField setReturnKeyType:UIReturnKeyDone];
    self.pwdField.delegate = self;
    
    //添加按钮点击事件
    [self.loginTypeButton addTarget:self action:@selector(showLoginType) forControlEvents:UIControlEventTouchUpInside];
    [self.mapTypeButton addTarget:self action:@selector(showMapType) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton addTarget:self action:@selector(didClickLoginButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setButtonStyle:(UIButton *)button title:(NSString *)title andPadding:(CGFloat)padding
{
    [button setBackgroundColor:[UIColor colorWithRed:0.970 green:0.966 blue:1.000 alpha:1.000]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:buttonTitleFont];
    [button.titleLabel sizeToFit];
    
    [button setImage:[UIImage imageNamed:@"more_unfold"] forState:UIControlStateNormal];
    CGFloat titleLeft = -(button.currentImage.size.width+padding/2);
    CGFloat titleRight = button.currentImage.size.width+padding/2;
    CGFloat imageLeft = button.titleLabel.bounds.size.width+padding/2;
    CGFloat imageRight = -(button.titleLabel.bounds.size.width+padding/2);
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, titleLeft, 0, titleRight)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, imageLeft, 0, imageRight)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(50);
    }];
    [self.loginBodyView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).offset(30);
        make.centerX.equalTo(self);
        make.width.equalTo(300);
        make.height.equalTo(400);
    }];
    
    [self labelViewLayout];
    [self buttonFieldLayout];
    
    [self.rememberLoginSwitch makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginBodyView);
        make.top.equalTo(self.mapTypeButton.bottom).offset(20);
    }];
    [self.rememberLoginLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rememberLoginSwitch);
        make.left.equalTo(self.rememberLoginSwitch.right).offset(5);
    }];
    
    [self.loginButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.rememberLoginLabel.bottom).offset(30);
        make.width.equalTo(self.loginBodyView);
        make.height.equalTo(40);
    }];
}

- (void)labelViewLayout
{
    CGFloat labelViewWidth = 80;
    CGFloat labelViewHeight = 40;
    CGFloat labelViewTopOffset = 25;
    [self.loginTypeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.loginBodyView);
        make.width.equalTo(labelViewWidth);
        make.height.equalTo(labelViewHeight);
    }];
    [self.loginTypeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.loginTypeView);
    }];
    
    [self.accountView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.loginTypeView);
        make.top.equalTo(self.loginTypeView.bottom).offset(labelViewTopOffset);
    }];
    [self.accountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.accountView);
    }];
    
    [self.pwdView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.loginTypeView);
        make.top.equalTo(self.accountView.bottom).offset(labelViewTopOffset);
    }];
    [self.pwdLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.pwdView);
    }];
    
    [self.mapView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.loginTypeView);
        make.top.equalTo(self.pwdView.bottom).offset(labelViewTopOffset);
    }];
    [self.mapLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.mapView);
    }];
}

- (void)buttonFieldLayout
{
    [self.loginTypeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginTypeView.right);
        make.right.equalTo(self.loginBodyView);
        make.top.bottom.equalTo(self.loginTypeView);
    }];
    [self.loginTypeOptionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginTypeButton.bottom);
        make.left.right.equalTo(self.loginTypeButton);
        make.height.equalTo(self.loginTypeButton).multipliedBy(2);
    }];
    
    [self.mapTypeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mapView.right);
        make.right.equalTo(self.loginBodyView);
        make.top.bottom.equalTo(self.mapView);
    }];
    [self.mapTypeOptionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mapTypeButton.bottom);
        make.left.right.equalTo(self.mapTypeButton);
        make.height.equalTo(self.mapTypeButton).multipliedBy(2);
    }];
    
    [self.accountField makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.loginTypeButton);
        make.top.bottom.equalTo(self.accountView);
    }];
    [self.pwdField makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.loginTypeButton);
        make.top.bottom.equalTo(self.pwdView);
    }];
}

/**
 *  显示登录类型选项
 */
- (void)showLoginType
{
    BOOL hide = self.loginTypeOptionView.isHidden;
    if (hide == YES) {
        [self.loginBodyView bringSubviewToFront:self.loginTypeOptionView];
    }
    [self.loginTypeOptionView setHidden:!hide];
}
/**
 *  显示地图类型选项
 */
- (void)showMapType
{
    BOOL hide = self.mapTypeOptionView.isHidden;
    if (hide == YES) {
        [self.loginBodyView bringSubviewToFront:self.mapTypeOptionView];
    }
    [self.mapTypeOptionView setHidden:!hide];
}

- (void)didClickLoginButton
{
    self.loginButtonClickCallback();
}

#pragma mark -- textField 代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -- UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseID;
    NSMutableArray *options = [NSMutableArray array];
    if (tableView.tag == 1) {
        reuseID = @"loginType";
        options[0] = @"设备号";
        options[1] = @"车牌号";
    }else{
        reuseID = @"mapType";
        options[0] = @"百度地图";
        options[1] = @"高德地图";
    }
    SKLoginOptionViewCell *cell = [[SKLoginOptionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    cell.textLabel.text = options[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKLoginOptionViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView.tag == 1) {
        [self setButtonStyle:self.loginTypeButton title:cell.textLabel.text andPadding:10];
    } else {
        [self setButtonStyle:self.mapTypeButton title:cell.textLabel.text andPadding:10];
    }
    [tableView setHidden:YES];
}
@end
