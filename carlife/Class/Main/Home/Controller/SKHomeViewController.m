//
//  SKHomeViewController.m
//  carlife
//
//  Created by Sky on 17/2/8.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKHomeViewController.h"
#import "SKHomeView.h"
#import "SKHomeModel.h"
#import "SKHomeViewCell.h"
#import "SKHomeHeaderView.h"

@interface SKHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) SKHomeView *homeView;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation SKHomeViewController

static NSString *cellID = @"homeCell";
static NSString *headID = @"homeHead";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"陈诚";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.homeView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview: self.homeView];
    
    [self.homeView registerClass:[SKHomeViewCell class] forCellWithReuseIdentifier:cellID];
    [self.homeView registerClass:[SKHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];
    
    self.homeView.delegate = self;
    self.homeView.dataSource = self;
    
    [self.navigationController.navigationBar setShadowImage:[UIImage uxy_imageWithColor:[UIColor clearColor]  size:CGSizeMake(SCREEN_WIDTH, 0.5)]];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"changeUser" object:nil] subscribeNext:^(id x) {
        
        self.title = [BQGlobalDaoModel sharedInstance].title;
        
        [SVProgressHUD showInfoWithStatus:@"切换中..."];

    }];

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}

#pragma mark -- 懒加载
- (SKHomeView *)homeView
{
    if (!_homeView) {
        _homeView = [SKHomeView homeView:self.view.bounds];
    }
    return _homeView;
}
- (NSMutableArray *)items
{
    if (!_items) {
        [SKHomeModel loadItems:^(NSArray *items) {
            _items = [NSMutableArray arrayWithArray:items];
        }];
    }
    return _items;
}

#pragma mark -- UICollectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SKHomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    SKHomeModel *itemModel = self.items[indexPath.item];
    cell.item = itemModel;
    CFWeakSelf(itemModel);
    CFWeakSelf(self);
    cell.clickItem = ^{
        if ([weakitemModel.controller isEqualToString:@"logout"]) {
            DDLogInfo(@"popcontroller？？");
            [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
            
        }else{
            id obj = [[NSClassFromString(weakitemModel.controller) alloc] init];
            if (obj) {
                [weakself.navigationController pushViewController:obj animated:YES];
            }
        }
    };
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SKHomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID forIndexPath:indexPath];
    [headerView setlayer];
    return headerView;
}

@end
