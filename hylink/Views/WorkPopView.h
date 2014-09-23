//
//  WorkPopView.h
//  hylink
//
//  Created by colin on 14-9-23.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkPopView : UIView

@property(nonatomic,copy)void(^submitCallBackBlock)(id para);

+ (instancetype)WorkPopViewWithType:(NSString *)typeString;

- (void)showInView:(UIView *)view_;

- (void)hide;

@end
