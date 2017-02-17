//
//  SKSettingViewController.m
//  carlife
//
//  Created by Sky on 2017/2/12.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKSettingViewController.h"

@interface SKSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *settingView;
@property (nonatomic, strong) NSMutableArray *settingItems;

@end

@implementation SKSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self.view addSubview:self.settingView];
    self.settingView.delegate = self;
    self.settingView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- 懒加载
- (UITableView *)settingView
{
    if (!_settingView) {
        _settingView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _settingView;
}
- (NSMutableArray *)settingItems
{
    if (!_settingItems) {
        NSDictionary *item1 = [NSDictionary dictionaryWithObjectsAndKeys:@"oiloff_icon",@"imageName",@"断油",@"title", nil];
        NSDictionary *item2 = [NSDictionary dictionaryWithObjectsAndKeys:@"oilon_icon",@"imageName",@"恢复油",@"title", nil];
        NSDictionary *item3 = [NSDictionary dictionaryWithObjectsAndKeys:@"deviceinfo_icon",@"imageName",@"设备信息",@"title", nil];
        NSDictionary *item4 = [NSDictionary dictionaryWithObjectsAndKeys:@"change_password_icon",@"imageName",@"修改密码",@"title", nil];
        _settingItems = [NSMutableArray arrayWithObjects:item1,item2,item3,item4, nil];
    }
    return _settingItems;
}

#pragma mark -- UITableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setting"];
    }
    NSDictionary *dict = self.settingItems[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"imageName"]];
    cell.textLabel.text = [dict objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
