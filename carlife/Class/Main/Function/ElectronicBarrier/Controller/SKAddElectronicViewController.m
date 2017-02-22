//
//  SKAddElectronicViewController.m
//  carlife
//
//  Created by Sky on 2017/2/22.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKAddElectronicViewController.h"

@interface SKAddElectronicViewController ()

@end

@implementation SKAddElectronicViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加电子围栏";
    UIButton *saveBt = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveBt setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [saveBt sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBt];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
