//
//  SettingViewController.m
//  hylink
//
//  Created by 李迪 on 14-9-6.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "SettingViewController.h"

typedef enum {
    SettingType_RecivedNotification = 0,
    SettingType_ChangePassword,
    SettingType_AboutUS,
    SettingType_Feedback,
    SettingType_VersionDescription,
    SettingType_VersionUpdate,
    SettingType_Logout
}SettingType;

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *settingTableView;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleWhite];
    // Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < SettingType_Logout) {
        return 55.0f;
    }
    else
    {
        return 130.0f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return SettingType_Logout + 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < SettingType_Logout) {
        static NSString *cell_id = @"setting_cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.backgroundColor = [UIColor clearColor];
        }
        
        for (UIView *v in cell.contentView.subviews) {
            [v removeFromSuperview];
        }
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 17.0f, 80.0f, 21.0f)];
        [cell.contentView addSubview:nameLabel];
        
        switch (indexPath.row) {
            case SettingType_RecivedNotification:
            {
                nameLabel.text = @"接收消息";
            }
                break;
            case SettingType_ChangePassword:
            {
                nameLabel.text = @"密码修改";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case SettingType_AboutUS:
            {
                nameLabel.text = @"关于我们";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            }
                break;
            case SettingType_Feedback:
            {
                nameLabel.text = @"反馈";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            }
                break;
            case SettingType_VersionDescription:
            {
                nameLabel.text = @"版本说明";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            }
                break;
            case SettingType_VersionUpdate:
            {
                nameLabel.text = @"版本更新";
            }
                break;
            default:
                break;
        }
        
        return cell;
    }
    else
    {
        //注销登录
        static NSString *cell_id_logout = @"setting_cell_logout";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id_logout];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id_logout];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            logoutBtn.frame = CGRectMake(15.0f, 35.0f, 290.0f, 49.0f);
            [logoutBtn setImage:[UIImage imageNamed:@"btn_logout"] forState:UIControlStateNormal];
            
            [logoutBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
                
                //退出登录
                
            }];
            
            [cell.contentView addSubview:logoutBtn];
        }
        
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
