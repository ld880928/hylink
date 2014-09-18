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

#import "CustomLayout.h"

@interface WorkingListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,WorkingListCollectionCellDataSource>

@property (weak, nonatomic) IBOutlet UIView *segmentedControlContainer;
@property (weak, nonatomic) IBOutlet UICollectionView *infoCollectionView;

@property (strong,nonatomic)NSMutableDictionary *workingDatasDictionary;

@property (nonatomic,strong)CustomSegmentedControl *control;

@property (strong,nonatomic)NSArray *navigationsArray;
@end

@implementation WorkingListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.workingDatasDictionary = [NSMutableDictionary dictionary];
    
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
    
    cell.dataSource = self;
    [cell.infoTableView reloadData];
    
    [cell.infoTableView addHeaderWithCallback:^{
        //此处刷新数据
        
        AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
        
        //参数
        NSDictionary *para = @{@"token":[AccountManager manager].token,
                               @"uid":[AccountManager manager].uid,
                               @"orgid":[AccountManager manager].orgid,
                               @"pagesize":@20,
                               @"page":@0,
                               @"type":[self.navigationsArray objectAtIndex:indexPath.item]};
        
        [requestManager POST:URL_SUB_WORKING_LIST parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([[responseObject objectForKey:@"status"] intValue] == Request_Status_Fail) {
                
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
                
                [cell.infoTableView reloadData];
                
            }
            
            [cell.infoTableView headerEndRefreshing];

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
            [cell.infoTableView headerEndRefreshing];

        }];

        
    }];
    

    cell.contentView.backgroundColor = [UIColor redColor];
    
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
    WorkingDetailViewController *controller = segue.destinationViewController;
    controller.mWork = sender;
}

@end
