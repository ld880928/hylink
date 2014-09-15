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

@interface WorkingListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *segmentedControlContainer;
@property (weak, nonatomic) IBOutlet UICollectionView *infoCollectionView;

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
    
    CustomLayout *customLayout = [[CustomLayout alloc] init];
    customLayout.cellCount = 4;
    self.infoCollectionView.collectionViewLayout = customLayout;
    
    // Do any additional setup after loading the view.
    NSArray *tags = @[@"全部",@"财务",@"行政",@"人事"];
    
    CustomSegmentedControl *control = [CustomSegmentedControl customSegmentedControlWithControls:tags valueChangedCallBlock:^(NSInteger index) {
        NSLog(@"%@",[tags objectAtIndex:index]);
    }];
    [self.segmentedControlContainer addSubview:control];
    
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"WorkingListCollectionCell";
    
    WorkingListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
    
    [cell.infoTableView addHeaderWithCallback:^{
        [cell.infoTableView performSelector:@selector(headerEndRefreshing) withObject:self afterDelay:1.0f];
    }];
    
    [cell.infoTableView headerBeginRefreshing];
    
    cell.contentView.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WorkingDetailViewController *controller = segue.destinationViewController;
    controller.workType = self.workType;
}

@end
