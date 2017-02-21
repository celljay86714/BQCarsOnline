//
//  UIPlaceHolderTextView.h
//  VKProprietorAssistant
//
//  Created by admin on 16/1/28.
//  Copyright © 2016年 Vanke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

- (void)textChanged:(NSNotification*)notification;

@end
