//
//  CustomTabBarView.h
//  hylink
//
//  Created by 李迪 on 14-9-6.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarView : UIView

@property(nonatomic,copy) void (^selectAtIndexBlock)(NSUInteger index);

+ (instancetype)customTabBarViewWithSelectAtIndexBlock:(void(^)(NSUInteger index))selectAtIndexBlock_;

@end
