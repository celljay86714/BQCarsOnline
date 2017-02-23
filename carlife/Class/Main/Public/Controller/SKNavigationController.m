//
//  SKNavigationController.m
//  carlife
//
//  Created by Sky on 17/1/12.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKNavigationController.h"

@implementation SKNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationBar setTintColor:[UIColor orangeColor]];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = BOLDSYSTEMFONT(16);
    [self.navigationBar setTitleTextAttributes:textAttrs];
    
    //隐藏返回按钮的文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
