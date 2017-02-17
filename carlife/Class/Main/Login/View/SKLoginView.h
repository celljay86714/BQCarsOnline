//
//  SKLoginView.h
//  carlife
//
//  Created by Sky on 17/1/11.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKLoginView : UIView

@property (nonatomic, copy) void (^loginButtonClickCallback)();

@end
