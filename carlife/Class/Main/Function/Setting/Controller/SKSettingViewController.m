//
//  SKSettingViewController.m
//  carlife
//
//  Created by Sky on 2017/2/12.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKSettingViewController.h"

@interface SKSettingViewController ()

@end

@implementation SKSettingViewController

- (instancetype)init
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SKSettingView" bundle:[NSBundle mainBundle]];
    SKSettingViewController *svc = (SKSettingViewController *)[sb instantiateViewControllerWithIdentifier:@"setting"];
    return svc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
