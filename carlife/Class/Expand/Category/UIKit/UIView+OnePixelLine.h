//
//  UIView+OnePixelLine.h
//  VKProprietorAssistant
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 Vanke. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kComonLineColor [UIColor colorWithRed:200 / 255.f green:200 / 255.f blue:202 / 255.f alpha:1.0f]

@interface UIView (OnePixelLine)

/**
 *  @author Vanke
 *
 *  自定义Line
 */

-(void)addLineViewTop:(CGFloat)top leftSpace:(CGFloat)aspace  rightSpace:(CGFloat)bspace  color:(UIColor *)color;

/**
 *  无边距
 */
- (void)addBottomLine;

/**
 * 加底部线
 *
 *  @param leftSpace 左边距
 */
- (void)addBottomLineWithLeftSpace:(CGFloat)leftSpace;


/**
 *  加线
 *
 *  @param hasUp     头部线
 *  @param hasDown   底部线
 *  @param color     颜色
 *  @param leftSpace 左边距
 *  @param rightSpace 右边距
 */
- (void)addLineLocationUp:(BOOL)hasUp
             locationDown:(BOOL)hasDown
                    color:(UIColor *)color
                leftSpace:(CGFloat)leftSpace
               rightSpace:(CGFloat)rightSpace;

/**
 *  加线
 *
 *  @param hasUp     头部线
 *  @param hasDown   底部线
 *  @param color     颜色
 *  @param board     线高度
 *  @param leftSpace 左边距
 *  @param rightSpace 右边距
 */
- (void)addLineLocationUp:(BOOL)hasUp
             locationDown:(BOOL)hasDown
                    color:(UIColor *)color
                lineBoard:(CGFloat )board
                leftSpace:(CGFloat)leftSpace
               rightSpace:(CGFloat)rightSpace;

@end

// 渐变色
@interface UIView (GradientColor)

- (void)addGradientColorStarColor:(UIColor *)startColor endColor:(UIColor *)endColor;

@end