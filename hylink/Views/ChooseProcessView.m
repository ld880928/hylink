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
    ChooseProcessView *view_ = [[[NSBundle mainBundle] loadNibNamed:@"ChooseProcessView" owner:self options:nil] lastObject];
    
    view_.isShow = NO;
    
    return view_;
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
