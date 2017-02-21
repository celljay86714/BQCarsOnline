//
//  AppDelegate.h
//  carlife
//
//  Created by Sky on 17/1/10.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "LoginViewController.h"
#import "SKTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

//登录页面
-(void)setupLoginViewController;
//跳转到首页
-(void)setupHomeViewController;

@end

