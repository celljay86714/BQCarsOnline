//
//  CommunityTableViewCell.m
//  BQJR
//
//  Created by jer on 2017/2/16.
//  Copyright © 2017年 jer. All rights reserved.
//

#import "CommunityTableViewCell.h"
#include "IDMPhotoBrowser.h"
@implementation CommunityTableViewCell

-(void)awakeFromNib{
    
    [super awakeFromNib];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = flowLayout;
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"smallcell"];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"smallcell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] init];
    cell.backgroundView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image =[UIImage imageNamed:@"abc123"];
    return cell;
    
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110 , 110);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *photos =[NSMutableArray arrayWithArray: @[[UIImage imageNamed: @"abc123"],[UIImage imageNamed: @"abc123"],[UIImage imageNamed: @"abc123"]]];
    
    NSArray *photosWithURL = [IDMPhoto photosWithImages:photos];
    IDMPhotoBrowser *browser= [[IDMPhotoBrowser alloc]initWithPhotos:photosWithURL animatedFromView:[collectionView cellForItemAtIndexPath:indexPath]];
    [browser setInitialPageIndex:indexPath.row];
    browser.displayDoneButton = NO;
    [[self uxy_currentViewController] presentViewController:browser animated:YES completion:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
