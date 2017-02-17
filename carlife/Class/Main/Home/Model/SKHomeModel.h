//
//  SKHomeModel.h
//  carlife
//
//  Created by Sky on 17/2/9.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKHomeModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *controller;

+ (instancetype)itemsWithDictionary:(NSDictionary *)dic;

+ (void)loadItems:(void(^)(NSArray *items))loadback;
@end
