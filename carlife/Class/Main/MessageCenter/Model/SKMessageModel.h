//
//  SKMessageModel.h
//  carlife
//
//  Created by Sky on 17/2/10.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKMessageModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *timeText;

+ (instancetype)messageWithDic:(NSDictionary *)dict;
@end
