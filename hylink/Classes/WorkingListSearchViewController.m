//
//  WorkingListSearchViewController.m
//  hylink
//
//  Created by 李迪 on 14-9-20.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "WorkingListSearchViewController.h"
#import "WorkingListCell.h"

@interface WorkingListSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong,nonatomic)NSMutableArray *datas;

@property (nonatomic,strong)UIView *maskView;

@property (nonatomic,assign)NSInteger page;
@end

@implementation WorkingListSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchBar.backgroundImage = [UIImage createImageWithColor:[UIColor clearColor]];
    
    [self.infoTableView registerNib:[UINib nibWithNibName:@"WorkingListCell" bundle:nil] forCellReuseIdentifier:@"WorkingListCell"];
    
    [self performBlock:^{
        [self.searchBar becomeFirstResponder];
    } afterDelay:.2f];
    
    __unsafe_unretained WorkingListSearchViewController *safe_self = self;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        if (!safe_self.maskView) {
            safe_self.maskView = [[UIView alloc] initWithFrame:safe_self.infoTableView.frame];
            safe_self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5f];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBarSearchButtonClicked:)];
            [safe_self.maskView addGestureRecognizer:tap];
            
            [safe_self.view addSubview:safe_self.maskView];
            
            if(!safe_self.searchBar.text || !safe_self.searchBar.text.length)
            {
                safe_self.datas = [NSMutableArray array];
                safe_self.page = 1;
                [safe_self.infoTableView reloadData];
            }
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [safe_self.maskView removeFromSuperview];
        safe_self.maskView = nil;
    }];
    
    [self.infoTableView addFooterWithCallback:^{
        //此处加载更多
        AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
        //参数
        NSString *searchString = self.searchBar.text;
        
        if (!searchString || !searchString.length)
        {
            [safe_self.infoTableView footerEndRefreshing];
            return;
        }
        
        NSDictionary *para = @{@"token":[AccountManager manager].token,
                               @"uid":[AccountManager manager].uid,
                               @"orgid":[AccountManager manager].orgid,
                               @"pagesize":@20,
                               @"page":[NSNumber numberWithLong:safe_self.page + 1],
                               @"type":searchString};
        
        [requestManager POST:URL_SUB_WORKING_LIST parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([[responseObject objectForKey:@"status"] intValue] == Request_Status_Fail) {
                
                [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            }
            else
            {
                NSArray *resDatas = [responseObject objectForKey:@"rows"];
                
                if (!resDatas || !resDatas.count) {
                    [SVProgressHUD showSuccessWithStatus:@"无更多数据"];
                    [safe_self.infoTableView footerEndRefreshing];
                    return;
                }
                
                for (int i=0; i<resDatas.count; i++) {
                    MWork *mWork = [[MWork alloc] initWithDictionary:[resDatas objectAtIndex:i]];
                    [safe_self.datas addObject:mWork];
                }
                
                self.page ++;
                
                [safe_self.infoTableView reloadData];
                
            }
            
            [safe_self.infoTableView footerEndRefreshing];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
            [safe_self.infoTableView footerEndRefreshing];
            
        }];
        
    }];
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"WorkingListCell";
    WorkingListCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    
    MWork *mWork = [self.datas objectAtIndex:indexPath.row];
    
    cell.labelTitle.text = mWork.f_work_processname;
    cell.labelTime.text = mWork.f_work_createtime;
    cell.labelName.text = mWork.f_work_initiator;
    [cell.imageViewType sd_setImageWithURL:[NSURL URLWithString:mWork.f_work_icon]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MWork *mWork = [self.datas objectAtIndex:indexPath.row];
    
    [self dismissViewControllerAnimated:NO completion:^{
        if (self.gotoWorkingDetailBlock) {
            self.gotoWorkingDetailBlock(mWork);
        }
    }];
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //搜索
    [self.searchBar resignFirstResponder];
    NSString *searchString = self.searchBar.text;
    
    __unsafe_unretained WorkingListSearchViewController *safe_self = self;

    if (searchString && searchString.length) {
        
        [SVProgressHUD showWithStatus:@"搜索中"];
        //此处刷新数据
        AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
        //参数
        NSDictionary *para = @{@"token":[AccountManager manager].token,
                               @"uid":[AccountManager manager].uid,
                               @"orgid":[AccountManager manager].orgid,
                               @"pagesize":@20,
                               @"page":@1,
                               @"type":searchString};
        
        [requestManager POST:URL_SUB_WORKING_LIST parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([[responseObject objectForKey:@"status"] intValue] == Request_Status_Fail) {
                [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            }
            else
            {
                NSArray *resDatas = [responseObject objectForKey:@"rows"];
                
                NSMutableArray *workModels = [NSMutableArray array];
                for (int i=0; i<resDatas.count; i++) {
                    MWork *mWork = [[MWork alloc] initWithDictionary:[resDatas objectAtIndex:i]];
                    [workModels addObject:mWork];
                }
                
                self.datas = workModels;
                self.page = 1;
                
                [safe_self.infoTableView reloadData];
                
            }
            
            [SVProgressHUD dismiss];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
        }];

    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UIKeyboardWillHideNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UIKeyboardWillShowNotification];
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
