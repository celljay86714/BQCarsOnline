//
//  SKHomeView.m
//  carlife
//
//  Created by Sky on 17/2/8.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKHomeView.h"
#import "SKHomeCollectionViewLayout.h"

@interface SKHomeView ()

@end

@implementation SKHomeView

+ (instancetype)homeView:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame collectionViewLayout:[SKHomeCollectionViewLayout flowlayout]];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

@end
