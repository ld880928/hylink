//
//  WorkingListSearchViewController.h
//  hylink
//
//  Created by 李迪 on 14-9-20.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkingListSearchViewController : UIViewController
@property(nonatomic,copy) void (^gotoWorkingDetailBlock)(MWork *mWork);
@end
