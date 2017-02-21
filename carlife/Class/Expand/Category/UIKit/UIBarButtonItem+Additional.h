//
//  UIViewController+BarItemView.h
//  VKProprietorAssistant
//
//  Created by Eric on 15/10/30.
//  Copyright (c) 2015年 Vanke. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^Action)();

@interface UIBarButtonItem (Additional)

- (id)initWithCustomImage:(UIImage*)aImage bgImage:(UIImage*)aBgImage actionBlock:(Action)block;
- (id)initWithCustomTitle:(NSString*)aTitle bgImage:(UIImage*)aBgImage actionBlock:(Action)block;

@end

