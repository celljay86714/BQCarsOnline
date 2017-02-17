//
//  SKNavigationController.m
//  carlife
//
//  Created by Sky on 17/1/12.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKNavigationController.h"

@implementation SKNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
