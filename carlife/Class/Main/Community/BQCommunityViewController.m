//
//  ViewController.m
//  BQJR
//
//  Created by jer on 2017/2/16.
//  Copyright © 2017年 jer. All rights reserved.
//

#import "BQCommunityViewController.h"
#import <MXSegmentedPager/MXSegmentedPagerController.h>
#import "CommunityTableViewCell.h"
#import "BQDiscussViewController.h"

@interface BQCommunityViewController ()<MXSegmentedPagerDelegate, MXSegmentedPagerDataSource, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) MXSegmentedPager  * segmentedPager;
@property (nonatomic, strong) UITableView  * plazaTableView;
@property (nonatomic, strong) UITableView  * recommendTableView;



@end

@implementation BQCommunityViewController

- (void)viewDidLoad {

    
    self.title =@"社区" ;
    
    [self.view addSubview:self.segmentedPager];

    self.segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedPager.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedPager.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedPager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    self.segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedPager.segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
    self.segmentedPager.segmentedControlEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    
    [self.plazaTableView registerNib:[UINib nibWithNibName:@"tableViewcell" bundle:nil] forCellReuseIdentifier:@"CommunityTableViewCell"];
    
    [self.recommendTableView registerNib:[UINib nibWithNibName:@"tableViewcell" bundle:nil] forCellReuseIdentifier:@"CommunityTableViewCell"];
    
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

- (UITableView *)plazaTableView {
    if (!_plazaTableView) {
        //Add a table page
        _plazaTableView = [[UITableView alloc] init];
        _plazaTableView.delegate = self;
        _plazaTableView.dataSource = self;
    }
    return _plazaTableView;
}

-(UITableView *)recommendTableView{

    if (!_recommendTableView) {
        _recommendTableView =[[UITableView alloc]init];
        _recommendTableView.delegate = self;
        _recommendTableView.dataSource = self;
    }
    return _recommendTableView;
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
    return 2;
}

- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    return @[@"广场", @"推荐"][index];
}

- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    return @[self.plazaTableView, self.recommendTableView][index];
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CommunityTableViewCell";
    CommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BQDiscussViewController *controller = [[UIStoryboard storyboardWithName:@"CommunityStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"BQDiscussViewController"];
    
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 315;
}

/**
 Description
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
