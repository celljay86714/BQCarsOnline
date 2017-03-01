//
//  ViewController.m
//  carlife
//
//  Created by Sky on 17/1/10.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "LoginViewController.h"
#import "SKLoginView.h"
#import "SKTabBarController.h"

@interface LoginViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) SKLoginView *loginView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg"]];
    [self.view addSubview:imageView];
    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [self.view addSubview:self.loginView];
    [self.loginView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //键盘出现时，点击空白处键盘消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
    //测试日志
    /*
    DDLogError(@"测试 Error 信息");
    DDLogWarn(@"测试 Warn 信息");
    DDLogDebug(@"测试 Debug 信息");
    DDLogInfo(@"测试 Info 信息");
    DDLogVerbose(@"测试 Verbose 信息");
    */
}

//点击空白处时调用
-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark -- UIGestureRecognizer代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

#pragma mark -- 懒加载
- (SKLoginView *)loginView
{
    if (!_loginView) {
        _loginView = [[SKLoginView alloc] init];
        CFWeakSelf(self);
        SKTabBarController *tabBarC = [[SKTabBarController alloc] init];
        [_loginView setLoginButtonClickCallback:^{
            [weakself presentViewController:tabBarC animated:YES completion:nil];
        }];
    }
    return _loginView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
