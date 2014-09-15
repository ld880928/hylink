//
//  PersonalViewController.m
//  hylink
//
//  Created by 李迪 on 14-9-6.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalCell.h"
#import "PersonalImageCell.h"

typedef enum
{
    PersonalCellType_Name = 0,
    PersonalCellType_Department,
    PersonalCellType_Phone,
    PersonalCellType_Email
}PersonalCellType;

@interface PersonalViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@end

@implementation PersonalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleWhite];
    // Do any additional setup after loading the view.
    
    [self.infoTableView addHeaderWithCallback:^{
        
        [self.infoTableView performSelector:@selector(headerEndRefreshing) withObject:self afterDelay:3.0f];

    }];
    
    [self.infoTableView headerBeginRefreshing];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section) {
        return 4;
    }
    else return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section) {
        return 55.0f;
    }
    else
    {
        return 150.0f;
    }
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
        headerLabel.text = @"基本信息";
        headerLabel.backgroundColor = [UIColor colorWithRed:220.0f / 255.0f green:220.0f / 255.0f blue:220.0f / 255.0f alpha:1.0f];
        [headerView addSubview:headerLabel];
        
        return headerView;
    }
    else
    {
        return nil;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section) {
        static NSString *personalCellID = @"PersonalCell";
        PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:personalCellID];
        if (!cell) {

        }
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        
        switch (indexPath.row) {
            case PersonalCellType_Name:
            {
                cell.labelKey.text = @"姓名";
                cell.labelValue.text = @"朱美玲";
            }
                break;
            case PersonalCellType_Department:
            {
                cell.labelKey.text = @"部门";
                cell.labelValue.text = @"财务部";
            }
                break;
            case PersonalCellType_Phone:
            {
                cell.labelKey.text = @"电话";
                cell.labelValue.text = @"18611115416";
            }
                break;
            case PersonalCellType_Email:
            {
                cell.labelKey.text = @"邮箱";
                cell.labelValue.text = @"zhumeil@mail.com.cn";
            }
                break;
            default:
                break;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {
        static NSString *personalImageCellID = @"PersonalImageCell";
        PersonalImageCell *cell = [tableView dequeueReusableCellWithIdentifier:personalImageCellID];
        if (!cell) {

        }
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
