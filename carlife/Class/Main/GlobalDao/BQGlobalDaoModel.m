//
//  BQGlobalDaoModel.m
//  carlife
//
//  Created by jer on 2017/2/27.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "BQGlobalDaoModel.h"

@implementation BQGlobalDaoModel

static BQGlobalDaoModel *globl = nil;

+ (BQGlobalDaoModel *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globl =[[BQGlobalDaoModel alloc] init];
    });
    
    [globl configView];
    return globl;
}


-(void)configView{

    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"toast_right"]];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"toast_wrong"]];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:16.0]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];

}

@end
