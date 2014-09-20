//
//  WorkingListCollectionCell.h
//  hylink
//
//  Created by colin on 14-9-15.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WorkingListCollectionCellDataSource <NSObject>

@required
- (NSInteger)numberOfDatasInItem:(UICollectionViewCell *)cell_;
- (NSArray *)getDatasForItem:(UICollectionViewCell *)cell_;

@end

@interface WorkingListCollectionCell : UICollectionViewCell<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)UITableView *infoTableView;
@property (nonatomic,weak)id<WorkingListCollectionCellDataSource> dataSource;

@property(nonatomic,copy) void (^gotoWorkingDetailBlock)(MWork *mWork);

@end
