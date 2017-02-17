//
//  CommunityTableViewCell.h
//  BQJR
//
//  Created by jer on 2017/2/16.
//  Copyright © 2017年 jer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)IBOutlet UIImageView *headerImage;
@property (nonatomic,strong)IBOutlet UILabel *nickLabel;
@property (nonatomic,strong)IBOutlet UILabel *timeLabel;
@property (nonatomic,strong)IBOutlet UILabel *contentLabel;
@property (nonatomic,strong)IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)IBOutlet UILabel *raiseNumber;
@property (nonatomic,strong)IBOutlet UILabel *messageNumber;


@end
