//
//  ChooseProcessView.m
//  hylink
//
//  Created by colin on 14-9-9.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "ChooseProcessView.h"

@interface ChooseProcessView()
@property(nonatomic,strong)UIView *maskView;

@end

@implementation ChooseProcessView

+ (instancetype)chooseProcessView
{
    ChooseProcessView *view_ = [[ChooseProcessView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 85.0f)];
    view_.backgroundColor = [UIColor whiteColor];
    
    view_.items = [NSMutableArray array];
    view_.isShow = NO;
    
    return view_;
}

- (void)addItemWithType:(NSString *)type showLabel:(NSString *)showLabel callBackBlock:(void(^)(id sender))callBackBlock
{
    CGFloat btnWidth = 80.0f;
    CGFloat btnHeight = 85.0f;
    
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(self.items.count * btnWidth, 0, btnWidth, btnHeight);
    actionBtn.frame = frame;
    NSString *imageName = [NSString stringWithFormat:@"btn_%@",type];
    [actionBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [actionBtn setTitle:showLabel forState:UIControlStateNormal];
    actionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    [actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [actionBtn setImageEdgeInsets:UIEdgeInsetsMake(15.5f, 25.0f, 35.5f, 25.0f)];
    CGFloat titleLeftInset = -1 * actionBtn.imageView.frame.size.width;
    [actionBtn setTitleEdgeInsets:UIEdgeInsetsMake(55.0f, titleLeftInset, 10.0f, 0)];

    actionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [actionBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (callBackBlock) {
            callBackBlock(type);
        }
    }];
    
    [self addSubview:actionBtn];
    [self.items addObject:actionBtn];
}

- (void)showInView:(UIView *)view_
{
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view_.bounds.size.width, view_.bounds.size.height)];
    self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5f];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.maskView addGestureRecognizer:tap];
    
    [view_ addSubview:self.maskView];
    
    
    [view_ addSubview:self];
    
    self.isShow = YES;
    
}

- (void)hide
{
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    
    [self removeFromSuperview];
    
    if (self.hideCallBackBlock) {
        self.hideCallBackBlock();
    }
    
    self.isShow = NO;
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
