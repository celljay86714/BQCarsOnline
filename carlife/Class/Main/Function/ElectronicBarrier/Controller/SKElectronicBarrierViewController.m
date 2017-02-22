//
//  SKElectronicBarrierViewController.m
//  carlife
//
//  Created by Sky on 17/2/13.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKElectronicBarrierViewController.h"
#import "SKAddElectronicViewController.h"

@interface SKElectronicBarrierViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *barrierView;
@property (nonatomic, strong) UIStoryboard *sb;

@end

@implementation SKElectronicBarrierViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"电子栅栏";
    UIButton *addBt = [UIButton buttonWithType:UIButtonTypeSystem];
    [addBt setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBt sizeToFit];
    [addBt addTarget:self action:@selector(didClickAddBt) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBt];
    
    [self.view addSubview:self.barrierView];
    self.barrierView.delegate = self;
    self.barrierView.dataSource = self;
}

- (void)didClickAddBt
{
    
    SKAddElectronicViewController *addC = (SKAddElectronicViewController *)[self.sb instantiateViewControllerWithIdentifier:@"AddBarrier"];
    [self.navigationController pushViewController:addC animated:YES];
}

#pragma mark -- 懒加载
- (UITableView *)barrierView
{
    if (!_barrierView) {
        _barrierView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _barrierView;
}
- (UIStoryboard *)sb
{
    if (!_sb) {
        _sb = [UIStoryboard storyboardWithName:@"ElecBarrier" bundle:[NSBundle mainBundle]];
    }
    return _sb;
}
#pragma mark -- UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"elec"];
    return cell;
}

@end
