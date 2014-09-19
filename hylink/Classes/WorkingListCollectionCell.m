//
//  WorkingListCollectionCell.m
//  hylink
//
//  Created by colin on 14-9-15.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "WorkingListCollectionCell.h"
#import "WorkingListCell.h"

@interface WorkingListCollectionCell()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation WorkingListCollectionCell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource) {
        return [self.dataSource numberOfDatasInItem:self];
    }
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"WorkingListCell";
    WorkingListCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    
    NSArray *datas = [self.dataSource getDatasForItem:self];
    MWork *mWork = [datas objectAtIndex:indexPath.row];
    
    cell.labelTitle.text = mWork.f_work_processname;
    cell.labelTime.text = mWork.f_work_createtime;
    cell.labelName.text = mWork.f_work_initiator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *datas = [self.dataSource getDatasForItem:self];
    
    if (self.gotoWorkingDetailBlock) {
        self.gotoWorkingDetailBlock([datas objectAtIndex:indexPath.row]);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
