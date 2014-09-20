//
//  ChooseProcessView.h
//  hylink
//
//  Created by colin on 14-9-9.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseProcessView : UIView

@property(nonatomic,copy)void(^hideCallBackBlock)();
@property(nonatomic,assign)BOOL isShow;
@property(nonatomic,strong)NSMutableArray *items;

+ (instancetype)chooseProcessView;

- (void)addItemWithType:(NSString *)type showLabel:(NSString *)showLabel callBackBlock:(void(^)(id sender))callBackBlock;

- (void)showInView:(UIView *)view_;

- (void)hide;

@end
