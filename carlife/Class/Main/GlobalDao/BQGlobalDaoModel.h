//
//  BQGlobalDaoModel.h
//  carlife
//
//  Created by jer on 2017/2/27.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BQGlobalDaoModel : NSObject

@property (nonatomic, strong) NSString *title;

+ (BQGlobalDaoModel *)sharedInstance;

@end
