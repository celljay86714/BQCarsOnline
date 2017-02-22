//
//  SKHistoryPathViewController.m
//  carlife
//
//  Created by Sky on 17/2/14.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKHistoryPathViewController.h"
#import "SKHistoryPathView.h"
#import "BQTrajectoryViewController.h"

@interface SKHistoryPathViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) SKHistoryPathView *pathView;

// 日期选择器
@property (nonatomic, strong) UIDatePicker *fromDatePicker;
@property (nonatomic, strong) UIDatePicker *toDatePicker;
// 工具条
@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation SKHistoryPathViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"历史轨迹";
    self.view = self.pathView;
    self.pathView.backgroundColor = [UIColor whiteColor];
    
    self.pathView.fromTextField.delegate = self;
    self.pathView.toTextField.delegate = self;
    
    [[self.pathView.searchBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        BQTrajectoryViewController *controller =[[BQTrajectoryViewController alloc]init];
        
        [self.navigationController pushViewController:controller animated:YES];
    }];
    
    
}

#pragma mark - UITextField 代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.inputView) return YES;
    if (textField == self.pathView.fromTextField) {
        textField.inputView = self.fromDatePicker;
    } else {
        textField.inputView = self.toDatePicker;
    }
    // 设置键盘输入辅助控件
    textField.inputAccessoryView = self.toolBar;
    return YES;
}

#pragma mark -- 懒加载
- (SKHistoryPathView *)pathView
{
    if (!_pathView) {
        _pathView = [[SKHistoryPathView alloc] initWithFrame:self.view.bounds];
    }
    return _pathView;
}
- (UIDatePicker *)fromDatePicker {
    if (_fromDatePicker == nil) {
        _fromDatePicker = [[UIDatePicker alloc] init];
        _fromDatePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        _fromDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _fromDatePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-(365 * 24 * 3600)];
        _fromDatePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:(365 * 24 * 3600)];
        _fromDatePicker.minuteInterval = 1;
        
        // 监听时间选择器值改变时间
        [_fromDatePicker addTarget:self action:@selector(dateValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _fromDatePicker;
}
- (UIDatePicker *)toDatePicker {
    if (_toDatePicker == nil) {
        _toDatePicker = [[UIDatePicker alloc] init];
        _toDatePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        _toDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _toDatePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-(365 * 24 * 3600)];
        _toDatePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:(365 * 24 * 3600)];
        _toDatePicker.minuteInterval = 1;
        
        // 监听时间选择器值改变时间
        [_toDatePicker addTarget:self action:@selector(dateValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _toDatePicker;
}

- (UIToolbar *)toolBar {
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        _toolBar.barTintColor = [UIColor orangeColor];
        _toolBar.tintColor = [UIColor whiteColor];
        UIBarButtonItem *lastItem = [[UIBarButtonItem alloc]
                                     initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(lastItemClick)];
    
        UIBarButtonItem *nextItem = [[UIBarButtonItem alloc]
                                     initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(nextItemClick)];
        
        // 创建确定item
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]
                                     initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneItemClick)];
        
        // 创建弹簧item
        UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        _toolBar.items = @[lastItem,nextItem,flexibleItem,doneItem];
    }
    return _toolBar;
}
//上一个
- (void)lastItemClick{
    if ([self.pathView.toTextField isFirstResponder]) {
        [self.pathView.fromTextField becomeFirstResponder];
    }
}
//下一个
- (void)nextItemClick {
    if ([self.pathView.fromTextField isFirstResponder]) {
        [self.pathView.toTextField becomeFirstResponder];
    }
}
//确定
- (void)doneItemClick {
    [self.view endEditing:YES];
}

- (void)dateValueChanged:(UIDatePicker *)datePicker {
    NSDate *date = datePicker == nil? [NSDate date]: datePicker.date;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat  =@"yyyy-MM-dd HH:mm";
    NSString *timeStr =[fmt stringFromDate:date];
    if (datePicker == self.fromDatePicker) {
        self.pathView.fromTextField.text = timeStr;
    } else {
        self.pathView.toTextField.text = timeStr;
    }
}
@end
