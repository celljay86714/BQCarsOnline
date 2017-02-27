//
//  SKElectronicMapViewController.h
//  carlife
//
//  Created by Sky on 2017/2/23.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKBaseViewController.h"

@interface SKElectronicMapViewController :SKBaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *plusImageView;
@property (weak, nonatomic) IBOutlet UILabel *radiusLabel;
@property (weak, nonatomic) IBOutlet UIButton *zoomOutBt;
@property (weak, nonatomic) IBOutlet UIButton *zoomInBt;
@property (weak, nonatomic) IBOutlet UISlider *rangeSlider;
@property (weak, nonatomic) IBOutlet UIButton *locationTypeBt;

@end
