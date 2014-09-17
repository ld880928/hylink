//
//  ForgotPasswordViewController.m
//  hylink
//
//  Created by 李迪 on 14-9-7.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFiledUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleWhite];
    // Do any additional setup after loading the view.
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 20.0f, 20.0f);
    
    [backBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
}

- (IBAction)submit:(id)sender
{
    NSString *userName = self.textFiledUserName.text;
    if (!userName || !userName.length) {
        [UIAlertView showWithNotice:@"请输入用户名"];
        return;
    }
    
    NSString *email = self.textFieldEmail.text;
    if (!email || !email.length) {
        [UIAlertView showWithNotice:@"请输入邮箱"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在处理"];
    
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    
    [requestManager POST:URL_SUB_FORGET parameters:@{@"uid":userName,@"email":email} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"status"] intValue] == Request_Status_OK) {
            
            [SVProgressHUD showSuccessWithStatus:@"密码已成功发送至您的邮箱"];
    
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
    
}

@end
