//
//  SKElectronicBarrierViewController.m
//  carlife
//
//  Created by Sky on 17/2/13.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKElectronicBarrierViewController.h"

@interface SKElectronicBarrierViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *barrierView;

@end

@implementation SKElectronicBarrierViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"电子栅栏";
    [self.view addSubview:self.barrierView];
    self.barrierView.delegate = self;
    self.barrierView.dataSource = self;
}

#pragma mark -- 懒加载
- (UITableView *)barrierView
{
    if (!_barrierView) {
        _barrierView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _barrierView;
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
