//
//  BQDiscussViewController.m
//  BQJR
//
//  Created by jer on 2017/2/17.
//  Copyright © 2017年 jer. All rights reserved.
//

#import "BQDiscussViewController.h"
#import "CommunityTableViewCell.h"
#import "BQInputView.h"

@interface BQDiscussViewController ()
@property (nonatomic, strong)IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHCons;
@property (weak, nonatomic) IBOutlet BQInputView *inputView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;



@end

@implementation BQDiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"tableViewcell" bundle:nil] forCellReuseIdentifier:@"CommunityTableViewCell"];
    
    // Do any additional setup after loading the view.
    
    
    // 监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 设置文本框占位文字
    _inputView.placeholder = @"请输入你的评论";
    _inputView.placeholderColor = [UIColor grayColor];
    
    // 监听文本框文字高度改变
    _inputView.yz_textHeightChangeBlock = ^(NSString *text,CGFloat textHeight){
        // 文本框文字高度改变会自动执行这个【block】，可以在这【修改底部View的高度】
        // 设置底部条的高度 = 文字高度 + textView距离上下间距约束
        // 为什么添加10 ？（10 = 底部View距离上（5）底部View距离下（5）间距总和）
        _bottomHCons.constant = textHeight + 16;
    };
    
    // 设置文本框最大行数
    _inputView.maxNumberOfLines = 4;
    
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
      
        [self.inputView resignFirstResponder];
        self.inputView.text = nil;
        self.bottomHCons.constant =40+10;
    }];

}


// 键盘弹出会调用
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 获取键盘frame
    CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 获取键盘弹出时长
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    // 修改底部视图距离底部的间距
    _bottomCons.constant = endFrame.origin.y != screenH?endFrame.size.height:0;
    
    // 约束动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
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
