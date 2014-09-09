//
//  WorkingListViewController.m
//  hylink
//
//  Created by 李迪 on 14-9-8.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "WorkingListViewController.h"
#import "WorkingListCell.h"
#import "WorkingDetailViewController.h"

@interface WorkingListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@end

@implementation WorkingListViewController

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
        
    // Do any additional setup after loading the view.
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 20.0f, 20.0f);
    
    [backBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [(HomeTabBarController *)self.tabBarController customTabBar].hidden = NO;
        [self.tabBarController.view bringSubviewToFront:[(HomeTabBarController *)self.tabBarController customTabBar]];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 0, 20.0f, 20.0f);
    
    [searchBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        //显示搜索框
        
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 44.0f)];
        
        searchBar.placeholder = @"搜索...";
        
        self.navigationItem.titleView = searchBar;
        [searchBar becomeFirstResponder];
        
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancleBtn setImage:[UIImage imageNamed:@"btn_cancle"] forState:UIControlStateNormal];
        cancleBtn.frame = CGRectMake(0, 0, 20.0f, 20.0f);
        
        [cancleBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            
            self.navigationItem.titleView = nil;
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];

        }];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancleBtn];

    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    [self performBlock:^{
        [(HomeTabBarController *)self.tabBarController customTabBar].hidden = YES;
    } afterDelay:.5f];
    
    
    //判断类型，加载数据
    if (self.workType == WorkType_Working) {
        self.title = @"待办事项";
    }
    else
    {
        self.title = @"已办事项";
    }
    
}

#pragma mark tableview

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"WoringListToWorkingDetailSegue" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *workingListCellID = @"WorkingListCell";
    WorkingListCell *cell = [tableView dequeueReusableCellWithIdentifier:workingListCellID];
    if (!cell) {
        
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WorkingDetailViewController *controller = segue.destinationViewController;
    controller.workType = self.workType;
}

@end
