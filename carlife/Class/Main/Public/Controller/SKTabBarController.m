//
//  SKTabBarController.m
//  carlife
//
//  Created by Sky on 17/1/12.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKTabBarController.h"
#import "SKNavigationController.h"
#import "SKHomeViewController.h"
#import "SKDeviceListViewController.h"
#import "SKMonitorCenterViewController.h"
#import "SKMessageCenterViewController.h"
#import "BQCommunityViewController.h"

@interface SKTabBarController ()<UITabBarControllerDelegate>

@end

@implementation SKTabBarController
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTabBarController];
    }
    return self;
}


- (void)setupTabBarController {
    /// 设置TabBar属性数组
    [self customizeTarbarAppearance];
    
    /// 设置控制器数组
    self.viewControllers =[self setupViewControllers];
    
    self.delegate = self;
    self.moreNavigationController.navigationBarHidden = YES;
}

- (void)customizeTarbarAppearance
{
    self.tabBarItemsAttributes =[self tabBarItemsAttributesForController];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];

    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

//控制器设置
- (NSArray *)setupViewControllers {
    SKHomeViewController *firstViewController = [[SKHomeViewController alloc] init];
    SKNavigationController *firstNavigationController = [[SKNavigationController alloc]
                                                         initWithRootViewController:firstViewController];
    
    SKDeviceListViewController *secondViewController = [[SKDeviceListViewController alloc] init];
    SKNavigationController *secondNavigationController = [[SKNavigationController alloc]
                                                          initWithRootViewController:secondViewController];
    
    SKMonitorCenterViewController *thirdViewController = [[SKMonitorCenterViewController alloc] init];
    SKNavigationController *thirdNavigationController = [[SKNavigationController alloc]
                                                         initWithRootViewController:thirdViewController];
    
    
    
   BQCommunityViewController *controller= [[UIStoryboard storyboardWithName:@"CommunityStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"BQCommunityViewController"];
    
  
    SKNavigationController *commNavigationController = [[SKNavigationController alloc]
                                                          initWithRootViewController:controller];
    
    [commNavigationController.navigationBar setBackgroundImage:[SKTabBarController uxy_imageWithColor:[UIColor whiteColor] size:CGSizeMake(375, 64)] forBarMetrics:UIBarMetricsDefault];
    
    
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 commNavigationController
                                 ];
    return viewControllers;
}

//TabBar文字跟图标设置
- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"main_tab_home_normal",
                                                 CYLTabBarItemSelectedImage : @"main_tab_home_selected",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"设备列表",
                                                  CYLTabBarItemImage : @"main_tab_list_normal",
                                                  CYLTabBarItemSelectedImage : @"main_tab_list_selected",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"监控中心",
                                                 CYLTabBarItemImage : @"main_tab_tracking_normal",
                                                 CYLTabBarItemSelectedImage : @"main_tab_tracking_selected",
                                                 };
    
    
    NSDictionary *communityTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"社区",
                                                 CYLTabBarItemImage : @"main_tab_home_normal",
                                                 CYLTabBarItemSelectedImage : @"main_tab_home_selected",
                                                 };

    
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       communityTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

+ (UIImage *)uxy_imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
