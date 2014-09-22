//
//  LoginViewController.m
//  hylink
//
//  Created by 李迪 on 14-9-7.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;

@end

@implementation LoginViewController

+ (void)logOut
{
    [[AccountManager manager] setIsLoginSuccess:NO];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navigationViewController = (UINavigationController *)[storyBoard instantiateViewControllerWithIdentifier:@"LoginNavigationViewController"];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:navigationViewController animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleWhite];
    // Do any additional setup after loading the view.
    self.textFieldUserName.text = [AccountManager manager].uname;
    
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    [self.view addGestureRecognizer:tap];
}

- (IBAction)login:(id)sender
{
    //验证登录信息
    NSString *userName = self.textFieldUserName.text;
    if (!userName || !userName.length) {
        [UIAlertView showWithNotice:@"请输入用户名"];
        return;
    }
    
    NSString *password = self.textFieldPassword.text;
    if (!password || !password.length) {
        [UIAlertView showWithNotice:@"请输入密码"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在登录..."];
    
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    
    [requestManager POST:URL_SUB_LOGIN parameters:@{@"uid":userName,@"passwd":password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"status"] intValue] == Request_Status_OK) {
            
            [AccountManager manager].uname  =   userName;
            [AccountManager manager].passwd =   password;
            [AccountManager manager].uid    =  [responseObject objectForKey:@"uid"];
            [AccountManager manager].orgid  =  [responseObject objectForKey:@"orgid"];
            [AccountManager manager].token  =  [responseObject objectForKey:@"token"];
            [[AccountManager manager] setIsLoginSuccess:YES];
            
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];

            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.textFieldUserName) {
        [self.textFieldPassword becomeFirstResponder];
    }
    else
    {
        [self.textFieldPassword resignFirstResponder];
        [self login:nil];
    }
    
    return YES;
}

- (void)hideKeyBoard:(UIGestureRecognizer *)ges
{
    [self.textFieldUserName resignFirstResponder];
    [self.textFieldPassword resignFirstResponder];
}

@end
