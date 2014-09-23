//
//  WorkViewController.m
//  hylink
//
//  Created by 李迪 on 14-9-6.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "WorkViewController.h"
#import "WorkingListViewController.h"

@interface WorkViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelWorkingCount;
@property (weak, nonatomic) IBOutlet UILabel *labelWorkedCount;

@end

@implementation WorkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage createImageWithColor:[UIColor clearColor]];
    
    [self setTitleWhite];
    // Do any additional setup after loading the view.
    
    //查询待办事项条数
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    //参数
    NSDictionary *para = @{@"token":[AccountManager manager].token,
                           @"uid":[AccountManager manager].uid};
    
    [requestManager POST:URL_SUB_WORKING_TOTAL parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue] == Request_Status_OK) {
            self.labelWorkingCount.text = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"total"]];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            self.labelWorkingCount.text = @"0";
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
    
    self.labelWorkedCount.text = @"138";
}

//待办事项列表
- (IBAction)gotoWorking:(id)sender
{
    [self performSegueWithIdentifier:@"WorkingToWorkingListSegue" sender:nil];
}

//已办事项列表
- (IBAction)gotoWorked:(id)sender
{
    [self performSegueWithIdentifier:@"WorkingToWorkingListSegue" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

@end
