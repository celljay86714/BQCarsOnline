//
//  SKMessageCenterViewController.m
//  carlife
//
//  Created by Sky on 17/2/8.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKMessageCenterViewController.h"
#import "SKMessageCenterViewCell.h"

@interface SKMessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *messageView;

@property (nonatomic, strong) NSMutableArray *messages;

@end

@implementation SKMessageCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"消息中心";
    [self.messageView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.messageView];
    self.messageView.delegate = self;
    self.messageView.dataSource = self;
}

#pragma mark -- 懒加载
- (UITableView *)messageView
{
    if (!_messageView) {
        _messageView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _messageView;
}
- (NSMutableArray *)messages
{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}

#pragma mark -- tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKMessageCenterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message"];
    if (!cell) {
        cell = [[SKMessageCenterViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"message"];
    }
    return cell;
}

@end
