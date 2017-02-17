//
//  SKNearbyViewFlowLayout.m
//  carlife
//
//  Created by Sky on 17/2/15.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKNearbyViewFlowLayout.h"

@implementation SKNearbyViewFlowLayout

static const CGFloat kLineSpacing = 20.f;
static const CGFloat kCellMargins = 20.f;
static const NSInteger kRowNumber = 3;
static const CGFloat kCellWidth  = 80.f;
static const CGFloat kCellHeight  = 100.f;

- (instancetype)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(kCellWidth, kCellHeight);
        self.minimumInteritemSpacing = (Main_Screen_Width-kCellMargins*2-kCellWidth*kRowNumber)/(kRowNumber-1);
        self.minimumLineSpacing = kLineSpacing;
        self.sectionInset = UIEdgeInsetsMake(20, kCellMargins, 0, kCellMargins);
        [self setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    return self;
}
@end
