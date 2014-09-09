//
//  WorkingDetailViewController.m
//  hylink
//
//  Created by 李迪 on 14-9-8.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "WorkingDetailViewController.h"
#import "WorkingDetailCell.h"
#import "WorkingDetailHistoryCell.h"

@interface WorkingDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@property (nonatomic,strong)ChooseProcessView *chooseProcessView;
@end

@implementation WorkingDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 20.0f, 20.0f);
    
    [backBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];

    //判断类型
    if (self.workType == WorkType_Working) {
        self.title = @"待办事项";
        
        UIButton *processBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [processBtn setImage:[UIImage imageNamed:@"btn_process"] forState:UIControlStateNormal];
        processBtn.frame = CGRectMake(0, 0, 20.0f, 20.0f);
        
        [processBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            if (self.chooseProcessView.isShow) {
                [self.chooseProcessView hide];
            }
            else
            {
                processBtn.transform = CGAffineTransformMakeRotation(M_PI);
                [self.chooseProcessView showInView:self.view];
            }
            
        }];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:processBtn];
        
        self.chooseProcessView = [ChooseProcessView chooseProcessView];
        
        self.chooseProcessView.hideCallBackBlock = ^{
            processBtn.transform = CGAffineTransformMakeRotation(0);
        };
        
        self.chooseProcessView.chooseSuccessCallBackBlock = ^(ProcessType type){
            
        };

        
    }
    else
    {
        self.title = @"已办事项";
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section) {
        return 35.0f;
    }
    else return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 35.0f)];
        headerView.backgroundColor = [UIColor colorWithRed:220.0f / 255.0f green:220.0f / 255.0f blue:220.0f / 255.0f alpha:1.0f];
        
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 7.0f, 80.0f, 21.0f)];
        headerLabel.text = @"审批历史";
        headerLabel.backgroundColor = [UIColor colorWithRed:220.0f / 255.0f green:220.0f / 255.0f blue:220.0f / 255.0f alpha:1.0f];
        [headerView addSubview:headerLabel];
        
        return headerView;
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取Cell
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    //更新UIView的layout过程和Autolayout
    //[cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    //[cell.contentView setNeedsLayout];
    //[cell.contentView layoutIfNeeded];
    
    //通过systemLayoutSizeFittingSize返回最低高度
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *workingDetailCellID = @"WorkingDetailCell";
        WorkingDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:workingDetailCellID];
        if (!cell) {
            
        }
        
        cell.labelValue.text = @"一个准一个准";
        
        if (indexPath.row == 4) {
            cell.labelValue.textAlignment = NSTextAlignmentLeft;
            cell.labelValue.text = @"一个准一个准一个准一个准一个准一个准一个准一个准一个准一个准一个准一个准一个准一个准";
        }
        
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {
        static NSString *workingDetailHistoryCellID = @"WorkingDetailHistoryCell";
        WorkingDetailHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:workingDetailHistoryCellID];
        if (!cell) {
            
        }
        
        cell.labelComment.text = @"一个准一个准一个准";

        if (indexPath.row == 0) {
            cell.lineTop.hidden = YES;
        }
        else cell.lineTop.hidden = NO;
        
        if (indexPath.row == 4) {
            cell.lineBottom.hidden = YES;
        }
        else cell.lineBottom.hidden = NO;
        
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
