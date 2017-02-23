//
//  SKAddElectronicViewController.m
//  carlife
//
//  Created by Sky on 2017/2/22.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKAddElectronicViewController.h"
#import "SKElectronicMapViewController.h"

@interface SKAddElectronicViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *barrierNameField;
@property (weak, nonatomic) IBOutlet UITextField *barrierLongitudeField;
@property (weak, nonatomic) IBOutlet UITextField *barrierLatitudeField;
@property (weak, nonatomic) IBOutlet UITextField *barrierRadiusField;

@property (nonatomic, strong) UIStoryboard *sb;
@end

@implementation SKAddElectronicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加电子围栏";
    UIButton *saveBt = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveBt setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [saveBt sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBt];
    
    [self setFields];
}

- (void)setFields
{
    self.barrierLongitudeField.delegate = self;
    self.barrierLatitudeField.delegate = self;
    self.barrierRadiusField.delegate = self;
}

- (void)didClickField
{
    SKElectronicMapViewController *addC = (SKElectronicMapViewController *)[self.sb instantiateViewControllerWithIdentifier:@"BarrierMap"];
    [self.navigationController pushViewController:addC animated:YES];
}

#pragma mark -- UITextField代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self didClickField];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 懒加载
- (UIStoryboard *)sb
{
    if (!_sb) {
        _sb = [UIStoryboard storyboardWithName:@"ElecBarrier" bundle:[NSBundle mainBundle]];
    }
    return _sb;
}

@end
