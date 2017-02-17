//
//  BQDiscussViewController.m
//  BQJR
//
//  Created by jer on 2017/2/17.
//  Copyright © 2017年 jer. All rights reserved.
//

#import "BQDiscussViewController.h"
#import "CommunityTableViewCell.h"

@interface BQDiscussViewController ()
@property (nonatomic, strong)IBOutlet UITableView *tableView;

@end

@implementation BQDiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"tableViewcell" bundle:nil] forCellReuseIdentifier:@"CommunityTableViewCell"];

    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger numberRow;
    
    if (section ==0) {
        numberRow =1;
    }
    else if (section ==1){
    
        numberRow =30;
    }
    
    return numberRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *tableViewCell = nil;
    
    if (indexPath.section ==0) {
        
        static NSString *CellIdentifier = @"CommunityTableViewCell";
        CommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        tableViewCell = cell;

    }
    
    else if (indexPath.section ==1){
    
        static NSString *CellIdentifier = @"Discuss";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        tableViewCell = cell;

    }
    
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height ;
    
    switch (indexPath.section) {
        case 0:
            height= 331;
            break;
        case 1:
            height= 70;
            break;
        default:
            break;
    }
    return height;
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
