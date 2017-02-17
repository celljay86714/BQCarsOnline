//
//  SKAlertViewController.m
//  carlife
//
//  Created by Sky on 2017/2/12.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKAlertViewController.h"

@interface SKAlertViewController ()

@end

@implementation SKAlertViewController

- (instancetype)init
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"alertView" bundle:[NSBundle mainBundle]];
    return [sb instantiateViewControllerWithIdentifier:@"alert"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
