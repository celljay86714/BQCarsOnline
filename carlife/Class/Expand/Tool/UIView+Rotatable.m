//
//  UIView+Rotatable.m
//
//  Created by Marat Al on 25.02.15.
//  Copyright (c) 2015 Favio Mobile. All rights reserved.
//

#import "UIView+Rotatable.h"
#import <objc/runtime.h>

@interface UIView ()

@property BOOL rotationInitialized;
@property CGPoint prevPoint;
@property CGAffineTransform initialTransform;
@property UIPanGestureRecognizer* gesture;

@end


@implementation UIView (Rotatable)

- (void) setRotationDelegate:(id<UIRotatableViewDelegate>)delegate {
    
    objc_setAssociatedObject(self, @selector(rotationDelegate), delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UIRotatableViewDelegate>) rotationDelegate {
    
    return objc_getAssociatedObject(self, @selector(rotationDelegate));
}

- (void) setAngle:(CGFloat)angle {
    
    if (self.rotationInitialized == NO)
    {
        self.initialTransform = self.transform;
        self.rotationInitialized = YES;
    }
    
    objc_setAssociatedObject(self, @selector(angle), [NSNumber numberWithFloat:angle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.transform = CGAffineTransformRotate(self.initialTransform, self.angle);
    self.layer.anchorPoint=CGPointMake(0, 0);
}

- (void) setAngle:(CGFloat)angle animated:(BOOL)animated {
    
    if (animated)
    {
        [UIView animateWithDuration:1.25 animations:^{
            self.angle = angle;
        }];
    }
    else
    {
        self.angle = angle;
    }
}

- (CGFloat) angle {
    
    return [objc_getAssociatedObject(self, @selector(angle)) floatValue];
}

- (void) setPrevPoint:(CGPoint)prevPoint {
    
    objc_setAssociatedObject(self, @selector(prevPoint), [NSValue valueWithCGPoint:prevPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint) prevPoint {
    
    return [(NSValue*)objc_getAssociatedObject(self, @selector(prevPoint)) CGPointValue];
}

- (void) setRotationInitialized:(BOOL)value {
    
    objc_setAssociatedObject(self, @selector(rotationInitialized), [NSNumber numberWithBool:value], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL) rotationInitialized {
    
    return [(NSNumber*)objc_getAssociatedObject(self, @selector(rotationInitialized)) boolValue];
}

- (void) setInitialTransform:(CGAffineTransform)initialTransform {
    
    objc_setAssociatedObject(self, @selector(initialTransform), [NSValue valueWithCGAffineTransform:initialTransform], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGAffineTransform) initialTransform {
    
    return [(NSValue*)objc_getAssociatedObject(self, @selector(initialTransform)) CGAffineTransformValue];
}

- (void) setGesture:(UIPanGestureRecognizer *)gesture {
    
    objc_setAssociatedObject(self, @selector(gesture), gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPanGestureRecognizer*) gesture {
    
    return objc_getAssociatedObject(self, @selector(gesture));
}

- (void) rotateItemAction:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint currPoint = [recognizer locationInView:recognizer.view.superview];
    
    CGPoint center = recognizer.view.center;
    
    CGFloat angle = atan2f(currPoint.y - center.y, currPoint.x - center.x) - atan2f(self.prevPoint.y - center.y, self.prevPoint.x - center.x);
    
    self.prevPoint = currPoint;
    
    self.angle += angle;
    
    if ([self.rotationDelegate respondsToSelector:@selector(angleChanged:)])
        [self.rotationDelegate performSelector:@selector(angleChanged:) withObject:self];
}

- (BOOL) gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)recognizer {
    
    self.rotationInitialized = NO;

    return YES;
}


- (void) setRotatable:(BOOL)rotatable {
    
    if (self.gesture == nil)
    {
        UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotateItemAction:)];
        panGesture.delegate = self;
        [self addGestureRecognizer:panGesture];
        self.gesture = panGesture;
    }
    
    self.gesture.enabled = rotatable;
}

- (BOOL) rotatable {
    
    return self.gesture.enabled;
}

@end


@implementation UIRotatableView

- (BOOL) rotatable {
    
    return super.rotatable;
}

- (void) setRotatable:(BOOL)rotatable {
    
    super.rotatable = rotatable;
}

@end
