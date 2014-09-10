//
//  CustomSegmentedControl.m
//  hylink
//
//  Created by 李迪 on 14-9-9.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "CustomSegmentedControl.h"
@interface CustomSegmentedControl()
@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,assign)NSInteger selectedIndex;

@property(nonatomic,copy) void (^valueChangedCallBackBlcok)(NSInteger index);
@end

@implementation CustomSegmentedControl

+ (instancetype)customSegmentedControlWithControls:(NSArray *)controls valueChangedCallBlock:(void (^)(NSInteger index))block_
{
    CustomSegmentedControl *control = [[CustomSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 46.0f)];
    control.valueChangedCallBackBlcok = block_;
    control.items = [NSMutableArray array];
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:control.frame];
    contentView.showsHorizontalScrollIndicator = NO;
    
    for (int i=0; i<controls.count; i++) {
        
        CustomSegmentedControlItem *item = [CustomSegmentedControlItem customSegmentedControlItemWithControl:[controls objectAtIndex:i]];
        item.frame = CGRectMake(item.bounds.size.width * i, 0, item.bounds.size.width, item.bounds.size.height);
        item.tag = i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:control action:@selector(itemClicked:)];
        [item addGestureRecognizer:tap];
        
        [contentView addSubview:item];
        [control.items addObject:item];
    }
    
    contentView.contentSize = CGSizeMake(controls.count * 80.0f, 46.0f);
    
    [control addSubview:contentView];
    
    control.selectedIndex = -1;  //只是不为正整数就行了
    
    [control selectItemAtIndex:0];
    
    return control;
}

- (void)itemClicked:(UITapGestureRecognizer *)ges
{
    [self selectItemAtIndex:ges.view.tag];
}

- (void)selectItemAtIndex:(NSInteger)index_
{
    for (int i=0; i<self.items.count; i++) {
        CustomSegmentedControlItem *item = [self.items objectAtIndex:i];
        if (i==index_) {
            item.isSelected = YES;
        }
        else
        {
            item.isSelected = NO;
        }
    }
    
    if (index_ != self.selectedIndex) {
        self.selectedIndex = index_;
        if (self.valueChangedCallBackBlcok) {
            self.valueChangedCallBackBlcok(self.selectedIndex);
        }
    }
}

@end


@interface CustomSegmentedControlItem()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *lineView;
@end

@implementation CustomSegmentedControlItem

+ (instancetype)customSegmentedControlItemWithControl:(NSString *)control
{
    CustomSegmentedControlItem *item = [[CustomSegmentedControlItem alloc] initWithFrame:CGRectMake(0, 0, 80.0f, 46.0f)];
    
    item.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 60.0f, 21.0f)];
    item.titleLabel.textAlignment = NSTextAlignmentCenter;
    item.titleLabel.text = control;
    item.titleLabel.textColor = [UIColor lightGrayColor];
    [item addSubview:item.titleLabel];
    
    item.lineView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 40.0f, 60.0f, 2.0f)];
    item.lineView.backgroundColor = OrangeColor;
    item.lineView.hidden = YES;
    [item addSubview:item.lineView];
    
    [item addObserver:item forKeyPath:@"isSelected" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    item.isSelected = NO;
    
    return item;
    
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"isSelected"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"isSelected"])
    {
        BOOL newState = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        BOOL oldState = [[change objectForKey:NSKeyValueChangeOldKey] boolValue];
        if (newState != oldState) {
            if (newState) {
                //选中
                self.titleLabel.textColor = OrangeColor;
                self.lineView.hidden = NO;
            }
            else
            {
                //反选
                self.titleLabel.textColor = [UIColor lightGrayColor];
                self.lineView.hidden = YES;
            }
        }
        
    }
    
}
@end