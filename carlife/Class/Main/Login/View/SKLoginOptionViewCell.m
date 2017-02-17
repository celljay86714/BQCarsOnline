//
//  SKLoginOptionViewCell.m
//  carlife
//
//  Created by Sky on 17/2/7.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKLoginOptionViewCell.h"

@implementation SKLoginOptionViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setAttributes];
    }
    return self;
}

- (void)setAttributes
{
    [self.textLabel setFont:[UIFont systemFontOfSize:14]];
    [self.textLabel setTextAlignment:NSTextAlignmentCenter];
    [self setBackgroundColor:[UIColor whiteColor]];
}

@end
