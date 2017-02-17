//
//  SKNearbyModel.h
//  carlife
//
//  Created by Sky on 17/2/15.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKNearbyModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;

+ (instancetype)itemsWithDictionary:(NSDictionary *)dic;

+ (void)loadItems:(void(^)(NSArray *items))loadback;
@end
