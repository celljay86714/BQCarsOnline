//
//  GVUserDefaults+SKProperties.h
//  carlife
//
//  Created by Sky on 17/1/13.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <GVUserDefaults/GVUserDefaults.h>

@interface GVUserDefaults (SKProperties)

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, assign) BOOL isFirstLaunch;

@end
