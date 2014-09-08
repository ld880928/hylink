//
//  WorkingListCell.h
//  hylink
//
//  Created by 李迪 on 14-9-8.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkingListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewType;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@end
