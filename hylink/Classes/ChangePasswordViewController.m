//
//  ChangePasswordViewController.m
//  hylink
//
//  Created by 李迪 on 14-9-21.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldOldPassword;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNewPassword;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)showOrHidePassword:(id)sender
{
    if ([sender isOn]) {
        self.textFieldOldPassword.secureTextEntry = NO;
        self.textFieldNewPassword.secureTextEntry = NO;
    }
    else
    {
        self.textFieldOldPassword.secureTextEntry = YES;
        self.textFieldNewPassword.secureTextEntry = YES;
    }
}

- (IBAction)confirmChange:(id)sender
{
    //验证登录信息
    NSString *oldPassword = self.textFieldOldPassword.text;
    if (!oldPassword || !oldPassword.length) {
        [UIAlertView showWithNotice:@"请输入旧密码"];
        return;
    }
    
    NSString *newPassword = self.textFieldNewPassword.text;
    if (!newPassword || !newPassword.length) {
        [UIAlertView showWithNotice:@"请输入新密码"];
        return;
    }
    
    NSDictionary *para = @{@"uid":[AccountManager manager].uid,
                           @"token":[AccountManager manager].token,
                           @"oldpasswd":oldPassword,
                           @"newpasswd":newPassword};
    
    [SVProgressHUD showWithStatus:@"正在处理..."];
    
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    
    [requestManager POST:URL_SUB_Modify_Password parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"status"] intValue] == Request_Status_OK) {
            
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            
            [self dismissViewControllerAnimated:YES completion:^{
                [LoginViewController logOut];
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
    if (textField == self.textFieldOldPassword) {
        [self.textFieldNewPassword becomeFirstResponder];
    }
    else
    {
        [self.textFieldNewPassword resignFirstResponder];
        [self confirmChange:nil];
    }
    
    return YES;
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
