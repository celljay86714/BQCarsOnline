//
//  SKHomeCollectionViewLayout.m
//  carlife
//
//  Created by Sky on 17/2/9.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKHomeCollectionViewLayout.h"

@implementation SKHomeCollectionViewLayout

static const CGFloat kLineSpacing = 20.f;
static const CGFloat kCellMargins = 15.f;
static const NSInteger kRowNumber = 4;
static const CGFloat kCellWidth  = 64.f;
static const CGFloat kCellHeight  = 84.f;
static const CGFloat kHeadHeight  = 200.f;

+ (instancetype)flowlayout
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(kCellWidth, kCellHeight);
        self.minimumInteritemSpacing = (Main_Screen_Width-kCellMargins*2-kCellWidth*kRowNumber)/(kRowNumber-1);
        self.minimumLineSpacing = kLineSpacing;
        self.sectionInset = UIEdgeInsetsMake(10, kCellMargins, 0, kCellMargins);
        self.headerReferenceSize = CGSizeMake(Main_Screen_Width, kHeadHeight);
        [self setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    return self;
}
@end
