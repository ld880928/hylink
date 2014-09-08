//
//  WorkingListCell.m
//  hylink
//
//  Created by 李迪 on 14-9-8.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "WorkingListCell.h"

@implementation WorkingListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
