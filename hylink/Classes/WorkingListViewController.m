//
//  WorkingListViewController.m
//  hylink
//
//  Created by 李迪 on 14-9-8.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "WorkingListViewController.h"
#import "WorkingListCollectionCell.h"
#import "WorkingDetailViewController.h"
#import "CustomSegmentedControl.h"
#import "WorkingListSearchViewController.h"

#import "CustomLayout.h"

@interface WorkingListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,WorkingListCollectionCellDataSource>

@property (weak, nonatomic) IBOutlet UIView *segmentedControlContainer;
@property (weak, nonatomic) IBOutlet UICollectionView *infoCollectionView;

@property (strong,nonatomic)NSMutableDictionary *workingDatasDictionary;

@property (strong,nonatomic)NSMutableDictionary *workingDataPagesDictionary;

@property (nonatomic,strong)CustomSegmentedControl *control;

@property (strong,nonatomic)NSArray *navigationsArray;
@end

@implementation WorkingListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.workingDatasDictionary = [NSMutableDictionary dictionary];
    self.workingDataPagesDictionary = [NSMutableDictionary dictionary];
    
    // Do any additional setup after loading the view.
    self.navigationsArray = @[@"全部",@"财务",@"行政",@"人事"];
    
    CustomLayout *customLayout = [[CustomLayout alloc] init];
    customLayout.cellCount = self.navigationsArray.count;
    self.infoCollectionView.collectionViewLayout = customLayout;
    self.control = [CustomSegmentedControl customSegmentedControlWithControls:self.navigationsArray valueChangedCallBlock:^(NSInteger index) {

        [self.infoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
        [self performSelector:@selector(refreshDataAtIndexPath:) withObject:[NSIndexPath indexPathForItem:index inSection:0] afterDelay:.1f];
        
    }];
    [self.segmentedControlContainer addSubview:self.control];
    
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
        [self performSegueWithIdentifier:@"WorkingListToSearchSegue" sender:self];
        /*
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
         */

    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    [self performBlock:^{
        [(HomeTabBarController *)self.tabBarController customTabBar].hidden = YES;
    } afterDelay:.5f];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.navigationsArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"WorkingListCollectionCell";
    
    WorkingListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
    cell.tag = indexPath.item;
    
    if (!cell.infoTableView) {
        CGRect frame_cell = [self.infoCollectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath].frame;
        CGRect frame = CGRectMake(0, 0,frame_cell.size.width, frame_cell.size.height);
        cell.infoTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [cell.infoTableView registerNib:[UINib nibWithNibName:@"WorkingListCell" bundle:nil] forCellReuseIdentifier:@"WorkingListCell"];
        cell.infoTableView.dataSource = cell;
        cell.infoTableView.delegate = cell;
        cell.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [cell.contentView addSubview:cell.infoTableView];
    }
    
    cell.gotoWorkingDetailBlock = ^(MWork *mWork){
        [self performSegueWithIdentifier:@"WoringListToWorkingDetailSegue" sender:mWork];
    };
    
    cell.dataSource = self;
    [cell.infoTableView reloadData];
    
    [cell.infoTableView addHeaderWithCallback:^{
        
        //此处刷新数据
        AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
        //参数
        NSString *type = [self.navigationsArray objectAtIndex:indexPath.item];
        if ([type isEqualToString:@"全部"]) {
            type = @"";
        }
        
        NSDictionary *para = @{@"token":[AccountManager manager].token,
                               @"uid":[AccountManager manager].uid,
                               @"orgid":[AccountManager manager].orgid,
                               @"pagesize":@20,
                               @"page":@1,
                               @"type":type};
        
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
                
                [self.workingDatasDictionary setObject:workModels forKey:indexPath];
                [self.workingDataPagesDictionary setObject:@1 forKey:indexPath];
                
                [cell.infoTableView reloadData];
                
            }
            
            [cell.infoTableView headerEndRefreshing];

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
            [cell.infoTableView headerEndRefreshing];

        }];

        
    }];
    
    [cell.infoTableView addFooterWithCallback:^{
        
        //此处加载更多
        AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
        //参数
        NSString *type = [self.navigationsArray objectAtIndex:indexPath.item];
        if ([type isEqualToString:@"全部"]) {
            type = @"";
        }
        
        NSNumber *page = [self.workingDataPagesDictionary objectForKey:indexPath];
        if (!page) {
            page = @1;
        }
        else
        {
            page = [NSNumber numberWithInt:[page intValue] + 1];
        }
                
        NSDictionary *para = @{@"token":[AccountManager manager].token,
                               @"uid":[AccountManager manager].uid,
                               @"orgid":[AccountManager manager].orgid,
                               @"pagesize":@20,
                               @"page":page,
                               @"type":type};
        
        [requestManager POST:URL_SUB_WORKING_LIST parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([[responseObject objectForKey:@"status"] intValue] == Request_Status_Fail) {
                
                [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            }
            else
            {
                NSArray *resDatas = [responseObject objectForKey:@"rows"];
                
                if (!resDatas || !resDatas.count) {
                    [SVProgressHUD showSuccessWithStatus:@"无更多数据"];
                    [cell.infoTableView footerEndRefreshing];
                    return;
                }
                
                NSMutableArray *workModels = [self.workingDatasDictionary objectForKey:indexPath];
                for (int i=0; i<resDatas.count; i++) {
                    MWork *mWork = [[MWork alloc] initWithDictionary:[resDatas objectAtIndex:i]];
                    [workModels addObject:mWork];
                }
                
                [self.workingDatasDictionary setObject:workModels forKey:indexPath];
                [self.workingDataPagesDictionary setObject:page forKey:indexPath];
                
                [cell.infoTableView reloadData];
                
            }
            
            [cell.infoTableView footerEndRefreshing];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
            [cell.infoTableView footerEndRefreshing];
            
        }];
        
    }];
    
    return cell;
}

#pragma mark WorkingListCollectionCellDataSource

- (void)refreshDataAtIndexPath:(NSIndexPath *)indexPath
{
    WorkingListCollectionCell *cell = (WorkingListCollectionCell *)[self.infoCollectionView cellForItemAtIndexPath:indexPath];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.infoTableView headerBeginRefreshing];
    });
}

- (NSInteger)numberOfDatasInItem:(WorkingListCollectionCell *)cell_
{
    return [[self getDatasForItem:cell_] count];
}

- (NSArray *)getDatasForItem:(WorkingListCollectionCell *)cell_
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:cell_.tag inSection:0];
    
    return [self.workingDatasDictionary objectForKey:indexPath];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView
{
    //算出滑动到哪一页，刷新当页的数据
    int page = floor(self.infoCollectionView.contentOffset.x / self.infoCollectionView.frame.size.width);
    
    [self.control selectItemAtIndex:page];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"WoringListToWorkingDetailSegue"]) {
        WorkingDetailViewController *controller = segue.destinationViewController;
        controller.mWork = sender;
    }
    if ([segue.identifier isEqualToString:@"WorkingListToSearchSegue"]) {
        WorkingListSearchViewController *controller = segue.destinationViewController;
        controller.gotoWorkingDetailBlock = ^(MWork *mWork){
            [self performSegueWithIdentifier:@"WoringListToWorkingDetailSegue" sender:mWork];
        };
    }

}

@end
