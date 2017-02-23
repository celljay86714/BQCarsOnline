//
//  UIView+Rotatable.h
//
//  Created by Marat Al on 25.02.15.
//  Copyright (c) 2015 Favio Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIRotatableViewDelegate <NSObject>

- (void) angleChanged:(id)sender;

@end

@interface UIView (Rotatable) <UIGestureRecognizerDelegate>

@property (assign, nonatomic) BOOL rotatable;
@property (assign, nonatomic) CGFloat angle;
@property (weak, nonatomic) IBOutlet id <UIRotatableViewDelegate> rotationDelegate;

- (void) setAngle:(CGFloat)angle animated:(BOOL)animated;

@end


IB_DESIGNABLE
@interface UIRotatableView : UIView

@property (assign, nonatomic) IBInspectable BOOL rotatable;

@end
