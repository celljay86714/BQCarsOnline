//
//  BQPostViewController.m
//  carlife
//
//  Created by jer on 2017/2/21.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "BQPostViewController.h"
#import "VKPhotoPicker.h"
#import "UIPlaceHolderTextView.h"

@interface BQPostViewController ()<VKPhotoPickerDelegate>

@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *postContent;
@property (weak, nonatomic) IBOutlet VKPhotoPicker *photoPicker;
@property (weak, nonatomic) IBOutlet UIView *tableHeaderView;


@end

@implementation BQPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = kCommonBackgroudColor;
    _photoPicker.delegate = self;
    _photoPicker.backgroundColor = [UIColor whiteColor];
    [[_photoPicker viewWithTag:898998] removeFromSuperview];
    [[_photoPicker viewWithTag:898999] removeFromSuperview];
    
    @weakify(self)
    CGFloat tableHaderH = 245;
    [RACObserve(_photoPicker, pickedImages) subscribeNext:^(NSMutableArray *value) {
        @strongify(self)
        
        if (value.count >= 3) {
            self.tableHeaderView.mj_h = tableHaderH + kImageWidth;
            self.tableView.tableHeaderView = self.tableHeaderView;
        } else {
            self.tableHeaderView.mj_h = tableHaderH-IMAGE_GAP;
            self.tableView.tableHeaderView = self.tableHeaderView;
        }
    }];
    
    _postContent.placeholder = @"说点什么...";
    
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomTitle:@"提交" bgImage:nil actionBlock:^{
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
