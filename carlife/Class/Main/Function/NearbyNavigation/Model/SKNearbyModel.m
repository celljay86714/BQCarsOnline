//
//  SKNearbyModel.m
//  carlife
//
//  Created by Sky on 17/2/15.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKNearbyModel.h"

@implementation SKNearbyModel

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
    NSArray *images = [NSArray arrayWithObjects:@"parkinglot_normal",@"bank_normal",
                       @"food_normal",@"hotel_normal",
                       @"stations_normal",@"hospital_normal",
                       @"bus_normal",@"supermarket_normal",
                       @"resort_normal",
                       nil];
    NSArray *titles = [NSArray arrayWithObjects:@"停车场",@"银行",@"美食",@"酒店",@"加油站",@"医院",@"公交站",@"超市",@"娱乐场", nil];
    for (int i = 0; i < images.count; ++i) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:titles[i],@"title",images[i],@"imageName", nil];
        SKNearbyModel *model = [SKNearbyModel itemsWithDictionary:dict];
        [items addObject:model];
    }
    loadback(items.copy);
}
@end
