//
//  SKHomeModel.m
//  carlife
//
//  Created by Sky on 17/2/9.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKHomeModel.h"

@interface SKHomeModel ()

@end

@implementation SKHomeModel

+ (instancetype)itemsWithDictionary:(NSDictionary *)dic
{
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dic];
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+ (void)loadItems:(void (^)(NSArray *))loadback
{
    NSMutableArray *items = [NSMutableArray array];
    NSArray *images = [NSArray arrayWithObjects:@"Circle_Tracking",@"Circle_History",
                       @"Circle_Electronic",@"Circle_Command",
                       @"Circle_DeviceMessage",@"Circle_Navigation",
                       @"Circle_OBDDiagnosis",@"Circle_AlarmSetting",
                       @"Circle_offlinemap",@"Circle_logout",
                       nil];
    NSArray *controllers = [NSArray arrayWithObjects:@"SKRealTimeLocationViewController",@"SKHistoryPathViewController",@"SKElectronicBarrierViewController",@"SKSettingViewController",@"SKDeviceMessageViewController",@"SKNearbyNavigationViewController",@"SKPeccancyViewController",@"SKAlertViewController",@"SKOfflineMapViewController",@"logout", nil];
    NSArray *titles = [NSArray arrayWithObjects:@"实时定位",@"历史轨迹",@"电子栅栏",@"设置",@"短信通知",@"周边导航",@"违章查询",@"报警提醒",@"离线地图",@"注销", nil];
    for (int i = 0; i < images.count; ++i) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:titles[i],@"title",images[i],@"imageName",controllers[i],@"controller", nil];
        SKHomeModel *model = [SKHomeModel itemsWithDictionary:dict];
        [items addObject:model];
    }
    loadback(items.copy);
}

@end
