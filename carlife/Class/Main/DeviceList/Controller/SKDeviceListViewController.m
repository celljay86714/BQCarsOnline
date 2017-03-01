//
//  SKDeviceListViewController.m
//  carlife
//
//  Created by Sky on 17/2/8.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "SKDeviceListViewController.h"
#import "MXSegmentedPager.h"

@interface SKDeviceListViewController ()<MXSegmentedPagerDelegate, MXSegmentedPagerDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MXSegmentedPager  * segmentedPager;


@end

@implementation SKDeviceListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设备列表";
    
    [self.view addSubview:self.segmentedPager];
    
    self.segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedPager.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedPager.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedPager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    self.segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedPager.segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
    self.segmentedPager.segmentedControlEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    

}

- (void)viewWillLayoutSubviews {
    self.segmentedPager.frame = (CGRect){
        .origin = CGPointZero,
        .size   = self.view.frame.size
    };
    [super viewWillLayoutSubviews];
}

- (MXSegmentedPager *)segmentedPager {
    if (!_segmentedPager) {
        
        // Set a segmented pager below the cover
        _segmentedPager = [[MXSegmentedPager alloc] init];
        _segmentedPager.delegate    = self;
        _segmentedPager.dataSource  = self;
    }
    return _segmentedPager;
}

-(UITableView *)allTableView{
    
    if (!_allTableView) {
        _allTableView =[[UITableView alloc]init];
        [_allTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

        _allTableView.delegate = self;
        _allTableView.dataSource = self;
    }
    return _allTableView;
}

-(UITableView *)onlineTableView{
    
    if (!_onlineTableView) {
        _onlineTableView =[[UITableView alloc]init];
        [_onlineTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

        _onlineTableView.delegate = self;
        _onlineTableView.dataSource = self;

    }
    return _onlineTableView;
}


-(UITableView *)offTableView{
    
    if (!_offTableView) {
        _offTableView =[[UITableView alloc]init];
        [_offTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

        _offTableView.delegate = self;
        _offTableView.dataSource = self;
    }
    return _offTableView;
}



#pragma mark <MXSegmentedPagerDelegate>

- (CGFloat)heightForSegmentedControlInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 30.f;
}

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title {
    NSLog(@"%@ page selected.", title);
}

#pragma mark <MXSegmentedPagerDataSource>

- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 3;
}

- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    return @[@"全部", @"在线",@"离线"][index];
}

- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    return @[self.allTableView,self.onlineTableView,self.offTableView][index];
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text=@"张三泉";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BQGlobalDaoModel *gloadModel =[BQGlobalDaoModel sharedInstance];
    gloadModel.title = @"张三泉";
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeUser" object:nil];
    [self.tabBarController setSelectedIndex:0];
    
}




@end
