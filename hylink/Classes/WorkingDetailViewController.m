//
//  WorkingDetailViewController.m
//  hylink
//
//  Created by 李迪 on 14-9-8.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "WorkingDetailViewController.h"

@interface WorkingDetailViewController ()

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
