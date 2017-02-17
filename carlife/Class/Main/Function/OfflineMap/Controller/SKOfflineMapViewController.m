//
//  SKOfflineMapViewController.m
//  carlife
//
//  Created by Sky on 17/2/15.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKOfflineMapViewController.h"
#import "SKOfflineMapView.h"
#import "SKMap.h"
#import "SKCityViewCell.h"
#import "SKDownloadViewCell.h"

@interface SKOfflineMapViewController ()<UITableViewDelegate,UITableViewDataSource,BMKOfflineMapDelegate,BMKMapViewDelegate>

@property (nonatomic, strong) SKOfflineMapView *offlineView;
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKOfflineMap *offlineMap;
@property (nonatomic, strong) NSArray *offlineCitys;
@property (nonatomic, strong) NSMutableArray *downloadMaps;

@end

@implementation SKOfflineMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    self.navigationItem.title = @"离线地图";
    self.view = self.offlineView;
    [self.offlineView addSubview:self.mapView];
    self.offlineView.backgroundColor = [UIColor whiteColor];
    
    CFWeakSelf(self);
    self.offlineView.segmentChange = ^(NSInteger index){
        switch (index) {
            case 0:
            {
                weakself.offlineView.downloadView.hidden = YES;
                weakself.offlineView.cityView.hidden = NO;
                [weakself.offlineView.cityView reloadData];
            }
                break;
            case 1:
            {
                weakself.offlineView.downloadView.hidden = NO;
                weakself.offlineView.cityView.hidden = YES;
                //获取各城市离线地图更新信息
                weakself.downloadMaps = [NSMutableArray arrayWithArray:[weakself.offlineMap getAllUpdateInfo]];
                [weakself.offlineView.downloadView reloadData];
            }
                break;
                
            default:
                break;
        }
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.mapView.delegate = self;
    self.offlineMap.delegate = self;
    
    self.offlineView.cityView.delegate = self;
    self.offlineView.cityView.dataSource = self;
    self.offlineView.downloadView.delegate = self;
    self.offlineView.downloadView.dataSource = self;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.mapView viewWillDisappear];
    
    self.mapView.delegate = nil;
    self.offlineMap.delegate = nil;
    
    self.offlineView.cityView.delegate = nil;
    self.offlineView.cityView.dataSource = nil;
    self.offlineView.downloadView.delegate = nil;
    self.offlineView.downloadView.dataSource = nil;
}

#pragma mark -- offlinemap代理
- (void)onGetOfflineMapState:(int)type withState:(int)state
{
    if (type == TYPE_OFFLINE_UPDATE) {
        //id为state的城市正在下载或更新，start后会毁掉此类型
        BMKOLUpdateElement* updateInfo;
        updateInfo = [self.offlineMap getUpdateInfo:state];
        NSLog(@"城市名：%@,下载比例:%d",updateInfo.cityName,updateInfo.ratio);
    }
    if (type == TYPE_OFFLINE_NEWVER) {
        //id为state的state城市有新版本,可调用update接口进行更新
        BMKOLUpdateElement* updateInfo;
        updateInfo = [self.offlineMap getUpdateInfo:state];
        NSLog(@"是否有更新%d",updateInfo.update);
    }
    if (type == TYPE_OFFLINE_UNZIP) {
        //正在解压第state个离线包，导入时会回调此类型
    }
    if (type == TYPE_OFFLINE_ZIPCNT) {
        //检测到state个离线包，开始导入时会回调此类型
        NSLog(@"检测到%d个离线包",state);
        if(state==0)
        {
            [self showImportMesg:state];
        }
    }
    if (type == TYPE_OFFLINE_ERRZIP) {
        //有state个错误包，导入完成后会回调此类型
        NSLog(@"有%d个离线包导入错误",state);
    }
    if (type == TYPE_OFFLINE_UNZIPFINISH) {
        NSLog(@"成功导入%d个离线包",state);
        //导入成功state个离线包，导入成功后会回调此类型
        [self showImportMesg:state];
    }
}
//导入提示框
- (void)showImportMesg:(int)count {}

#pragma makr -- tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == cityViewTag)
    {
        return self.offlineCitys.count;
    }else{
        return self.downloadMaps.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    if(tableView.tag == cityViewTag)
    {
        CellIdentifier = @"OfflineMapCityCell";
        SKCityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SKCityViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        BMKOLSearchRecord* item = [self.offlineCitys objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", item.cityName];
        //转换包大小
        NSString*packSize = [SKMap getDataSizeString:item.size];
        cell.sizeLabel.text = packSize;
        return cell;
        
    }else{
        CellIdentifier = @"OfflineDownloadCell";
        if(self.downloadMaps!=nil && self.downloadMaps.count > indexPath.row)
        {
            BMKOLUpdateElement* item = [self.downloadMaps objectAtIndex:indexPath.row];
            SKDownloadViewCell *cell = [[SKDownloadViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            CFWeakSelf(self);
            CFWeakSelf(item);
            CFWeakSelf(indexPath);
            CFWeakSelf(tableView);
            cell.deleteCity = ^{
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确定要删除 %@ 的离线包吗",weakitem.cityName] message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakself.offlineMap remove:weakitem.cityID];
                    [weakself.downloadMaps removeObjectAtIndex:weakindexPath.row];
                    [weaktableView reloadData];
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertC addAction:confirm];
                [alertC addAction:cancel];
                [weakself presentViewController:alertC animated:YES completion:nil];
            };
            //是否可更新
            if(item.update)
            {
                
            }
            else
            {
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %d%%", item.cityName,item.ratio];
            }
            return cell;
        }
    }
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == cityViewTag) {
        BMKOLSearchRecord* item = [self.offlineCitys objectAtIndex:indexPath.row];
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确定要下载 %@ 的离线包吗",item.cityName] message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.offlineMap start:item.cityID];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertC addAction:confirm];
        [alertC addAction:cancel];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

#pragma mark -- 懒加载
- (BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    }
    return _mapView;
}
- (SKOfflineMapView *)offlineView
{
    if (!_offlineView) {
        _offlineView = [[SKOfflineMapView alloc] initWithFrame:self.view.bounds];
    }
    return _offlineView;
}
- (BMKOfflineMap *)offlineMap
{
    if (!_offlineMap) {
        _offlineMap = [[BMKOfflineMap alloc] init];
    }
    return _offlineMap;
}
- (NSArray *)offlineCitys
{
    if (!_offlineCitys) {
        _offlineCitys = [self.offlineMap getOfflineCityList];
    }
    return _offlineCitys;
}

- (void)dealloc {
    if (self.offlineMap) {
        self.offlineMap = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
