//
//  CustomSegmentedControl.h
//  hylink
//
//  Created by 李迪 on 14-9-9.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSegmentedControl : UIView

@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,assign)NSInteger selectedIndex;

- (void)selectItemAtIndex:(NSInteger)index_;

+ (instancetype)customSegmentedControlWithControls:(NSArray *)controls valueChangedCallBlock:(void (^)(NSInteger index))block_;


@end

@interface CustomSegmentedControlItem : UIView
@property(nonatomic,assign)BOOL isSelected;

+ (instancetype)customSegmentedControlItemWithControl:(NSString *)control;
@end