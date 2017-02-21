//
//  UIView+OnePixelLine.m
//  VKProprietorAssistant
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 Vanke. All rights reserved.
//

#import "UIView+OnePixelLine.h"

#define kTagLineView 1007

@implementation UIView (OnePixelLine)


-(void)addLineViewTop:(CGFloat)top leftSpace:(CGFloat)aspace  rightSpace:(CGFloat)bspace  color:(UIColor *)color{

    UIView *lineView = [UIView new];
    lineView.backgroundColor = color?:kComonLineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(aspace);
        make.right.equalTo(self).offset(-bspace);
        make.height.equalTo(@0.3);
        make.top.equalTo(self).offset(top);
    }];
    
}

/**
 *  无边界
 */
- (void)addBottomLine {
    [self addBottomLineWithLeftSpace:0.0f];
}

- (void)addBottomLineWithLeftSpace:(CGFloat)leftSpace {
    [self addLineLocationUp:NO locationDown:YES color:nil leftSpace:leftSpace rightSpace:0.0f]; // VKColorFromRGB(221, 219, 206)
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace {
    [self addLineLocationUp:hasUp locationDown:hasDown color:color leftSpace:leftSpace rightSpace:0.0f]; // VKColorFromRGB(221, 219, 206)

}

- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}

- (void)addLineLocationUp:(BOOL)hasUp
             locationDown:(BOOL)hasDown
                    color:(UIColor *)color
                leftSpace:(CGFloat)leftSpace
               rightSpace:(CGFloat)rightSpace {
    

    if (!color) {
        color = kComonLineColor;
    }
    
    if (hasUp) {
        
        if ([self viewWithTag:898999] !=nil) {
            
            
        }else{
        
            UIView *lineView = [UIView new];
            lineView.backgroundColor = color;
            [self addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(leftSpace);
                make.right.equalTo(self).offset(-rightSpace);
                make.height.equalTo(@0.3);
                make.top.equalTo(self);
            }];
            
            lineView.tag =898999;
        }
    }
    if (hasDown) {
        
        if ([self viewWithTag:898998]!=nil) {
            
        }
        else{
    
            UIView *lineView = [UIView new];
            lineView.backgroundColor = color;
            [self addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(leftSpace);
                make.right.equalTo(self).offset(-rightSpace);
                make.height.equalTo(@0.3);
                make.bottom.equalTo(self);
            }];
            lineView.tag =898998;

        }
    }
}

- (void)addLineLocationUp:(BOOL)hasUp
             locationDown:(BOOL)hasDown
                    color:(UIColor *)color
                lineBoard:(CGFloat )board
                leftSpace:(CGFloat)leftSpace
               rightSpace:(CGFloat)rightSpace {
    
    
    if (!color) {
        color = kComonLineColor;
    }
    
    if (hasUp) {
        
        if ([self viewWithTag:898999] !=nil) {
            
            
        }else{
            
            UIView *lineView = [UIView new];
            lineView.backgroundColor = color;
            [self addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(leftSpace);
                make.right.equalTo(self).offset(-rightSpace);
                make.height.equalTo(@(board));
                make.top.equalTo(self);
            }];
            
            lineView.tag =898999;
        }
    }
    if (hasDown) {
        
        if ([self viewWithTag:898998]!=nil) {
            
        }
        else{
            
            UIView *lineView = [UIView new];
            lineView.backgroundColor = color;
            [self addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(leftSpace);
                make.right.equalTo(self).offset(-rightSpace);
                make.height.equalTo(@(board));
                make.bottom.equalTo(self);
            }];
            lineView.tag =898998;
            
        }
    }
}



@end


// 渐变色
@implementation UIView (GradientColor)

- (void)addGradientColorStarColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    CAGradientLayer *layer = [CAGradientLayer new];
    
//    UIColor *startColor = [UIColor colorWithRed:65.0f / 255.0f green:45.0f / 255.0f blue:6.0f / 255.0f alpha:1.0f];
//    UIColor *endColor   = [UIColor colorWithRed:118.0f / 255.0f green:88.0f / 255.0f blue:26.0f / 255.0f alpha:1.0f];
    
    layer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    //    layer.startPoint = [UIColor randomColor];
    //    layer.endPoint = [UIColor randomColor];
    // 起始点
    layer.startPoint = CGPointMake(0, 0);
    // 结束点
    layer.endPoint   = CGPointMake(0, 1);
    layer.frame = self.bounds;
    [self.layer insertSublayer:layer atIndex:0];
}

@end
