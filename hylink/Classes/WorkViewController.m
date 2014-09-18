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
    
    self.labelWorkingCount.text = @"20";
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
