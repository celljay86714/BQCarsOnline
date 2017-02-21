//
//  UIViewController+BarItemView.m
//  VKProprietorAssistant
//
//  Created by Eric on 15/10/30.
//  Copyright (c) 2015年 Vanke. All rights reserved.
//

#import "UIBarButtonItem+Additional.h"

@implementation UIBarButtonItem (Additional)

- (id)initWithCustomImage:(UIImage*)aImage bgImage:(UIImage*)aBgImage actionBlock:(Action)block {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,aBgImage.size.width,aBgImage.size.height);
    [button setImage:aImage forState:UIControlStateNormal];
    [button setBackgroundImage:aBgImage forState:UIControlStateNormal];

    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (block) {
            block();
        }
    }];
    
    self = [self initWithCustomView:button];
    return self;
}

- (id)initWithCustomTitle:(NSString*)aTitle bgImage:(UIImage*)aBgImage actionBlock:(Action)block {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIFont* font = [UIFont systemFontOfSize:17.0f];
    button.titleLabel.font = font;
    CGSize size = [aTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 29)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                         attributes:@{NSFontAttributeName:font}
                                            context:nil].size;
    NSInteger buttonWidth = 0;
    if (size.width < 41) {
        buttonWidth = 41;
    } else {
        buttonWidth = 60;
    }
    
    button.frame = CGRectMake(0,0,buttonWidth,29);
    button.mj_size = size;
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setTitleColor:UXYColorFromRGBA(243, 152, 0, 1) forState:UIControlStateNormal];
    [button setBackgroundImage:aBgImage forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (block) {
            block();
        }
    }];
    button.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);


    self = [self initWithCustomView:button];
    return self;
}
@end
