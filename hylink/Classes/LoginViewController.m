//
//  LoginViewController.m
//  hylink
//
//  Created by 李迪 on 14-9-7.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleWhite];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender
{
    //验证登录信息
    
    [SVProgressHUD showWithStatus:@"正在登录..."];
    
    NSLog(@"%d  %d",Request_Status_OK,Request_Status_Fail);
    
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    
    [requestManager POST:URL_SUB_LOGIN parameters:@{@"uid":@"infoship",@"passwd":@"1"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

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
