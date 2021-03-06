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
#import "WorkPopView.h"

@interface WorkingDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@property (nonatomic,strong)ChooseProcessView *chooseProcessView;
@property (nonatomic,strong)WorkPopView *workPopViewHandle;

@property (nonatomic,strong)MWorkDetail *mWorkDetail;
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

    [self.infoTableView addHeaderWithCallback:^{
        
        //此处刷新数据
        AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
        //参数
        NSDictionary *para = @{@"token":[AccountManager manager].token,
                               @"uid":[AccountManager manager].uid,
                               @"orgid":[AccountManager manager].orgid,
                               @"taskid":self.mWork.f_work_taskid};
        
        [requestManager POST:URL_SUB_WORKING_DETAIL parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([[responseObject objectForKey:@"status"] intValue] == Request_Status_OK) {
                
                self.mWorkDetail = [[MWorkDetail alloc] initWithDictionary:responseObject];
                
                [self.infoTableView reloadData];
                [self refreshProgressViewWithActions:self.mWorkDetail.f_work_detail_actions];
                
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            }
            
            [self.infoTableView headerEndRefreshing];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
            [self.infoTableView headerEndRefreshing];
            
        }];
        
        
    }];
    
    [self.infoTableView headerBeginRefreshing];
}

- (void)refreshProgressViewWithActions:(NSArray *)actions
{
    //判断类型
    UIButton *processBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [processBtn setImage:[UIImage imageNamed:@"btn_process"] forState:UIControlStateNormal];
    processBtn.frame = CGRectMake(0, 0, 20.0f, 20.0f);
    
    self.chooseProcessView = [ChooseProcessView chooseProcessView];
    
    self.chooseProcessView.hideCallBackBlock = ^{
        processBtn.transform = CGAffineTransformMakeRotation(0);
    };
    
    [processBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (self.chooseProcessView.isShow) {
            [self.chooseProcessView hide];
        }
        else
        {
            if (self.workPopViewHandle) {
                [self.workPopViewHandle hide];
            }
            processBtn.transform = CGAffineTransformMakeRotation(M_PI);
            [self.chooseProcessView showInView:self.view];
        }
        
    }];
    
    for (int i=0; i<actions.count; i++) {
        
        MWorkDetailAction *action = [actions objectAtIndex:i];
        if (!action.f_work_detail_action_disable) {
            
            __unsafe_unretained WorkingDetailViewController *safe_self = self;
            
            [self.chooseProcessView addItemWithType:action.f_work_detail_action_id showLabel:action.f_work_detail_action_label callBackBlock:^(id sender) {
                
                [safe_self.chooseProcessView hide];
                
                safe_self.workPopViewHandle = [WorkPopView WorkPopViewWithType:sender];
                
                AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
                
                safe_self.workPopViewHandle.submitCallBackBlock = ^(id para_){
                    
                    [SVProgressHUD showWithStatus:@"正在提交"];
                    
                    NSDictionary *para = @{@"token":[AccountManager manager].token,
                                           @"uid":[AccountManager manager].uid,
                                           @"orgid":[AccountManager manager].orgid,
                                           @"taskid":safe_self.mWork.f_work_taskid,
                                           @"action":[para_ objectForKey:@"action"],
                                           @"other":[para_ objectForKey:@"other"],
                                           @"memo":[para_ objectForKey:@"memo"],
                                           @"items":@[]};
                    
                    [requestManager POST:URL_SUB_WORKING_SUBMIT parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        
                        if ([[responseObject objectForKey:@"status"] intValue] == Request_Status_OK) {
                            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                            [safe_self.workPopViewHandle hide];
                            [safe_self.navigationController popViewControllerAnimated:YES];
                            
                        }
                        else
                        {
                            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
                            
                        }
                        
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        [SVProgressHUD showErrorWithStatus:@"网络异常"];
                        
                    }];
                };
                
                [safe_self.workPopViewHandle showInView:safe_self.view];
                
            }];
            
        }
        
        
    }
    
    if (self.chooseProcessView.items.count) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:processBtn];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return self.mWorkDetail.f_work_detail_comments.count;
    }
    else return self.mWorkDetail.f_work_detail_items.count;
    
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
        
        MWorkDetailItem *item = [self.mWorkDetail.f_work_detail_items objectAtIndex:indexPath.row];
        
        cell.labelKey.text = item.f_work_detail_item_label;
        cell.labelValue.text = [NSString stringWithFormat:@"%@",item.f_work_detail_item_value];
        
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
        
        MWorkDetailComment *comment = [self.mWorkDetail.f_work_detail_comments objectAtIndex:indexPath.row];
        
        cell.labelComment.text = comment.f_work_detail_comment_memo;
        cell.labelName.text =  comment.f_work_detail_comment_people;
        cell.labelTime.text = comment.f_work_detail_comment_time;
        
        if (indexPath.row == 0) {
            cell.lineTop.hidden = YES;
        }
        else cell.lineTop.hidden = NO;
        
        if (indexPath.row == self.mWorkDetail.f_work_detail_comments.count - 1) {
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
