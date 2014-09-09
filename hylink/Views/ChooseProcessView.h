//
//  ChooseProcessView.h
//  hylink
//
//  Created by colin on 14-9-9.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ProcessType_Agree=0,
    ProcessType_Reject,
    ProcessType_Ask_Sponsor,
    ProcessType_Ask_Other
}ProcessType;

@interface ChooseProcessView : UIView

@property(nonatomic,copy)void(^hideCallBackBlock)();
@property(nonatomic,copy)void(^chooseSuccessCallBackBlock)(ProcessType type);
@property(nonatomic,assign)BOOL isShow;

+ (instancetype)chooseProcessView;

- (void)showInView:(UIView *)view_;

- (void)hide;

@end
