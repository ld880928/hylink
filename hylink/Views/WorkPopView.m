//
//  WorkPopView.m
//  hylink
//
//  Created by colin on 14-9-23.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "WorkPopView.h"

/*
 agree
 disagree
 askInitiator
 askOther
 */

@interface WorkPopView()
@property(nonatomic,strong)UIView *maskView;
@property (weak, nonatomic) IBOutlet UIButton *chooseOtherBtn;
@property (weak, nonatomic) IBOutlet UITextView *adviceTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chooseOtherBtnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *space;

@property (strong,nonatomic)NSString *type;
@end

@implementation WorkPopView

+ (instancetype)WorkPopViewWithType:(NSString *)typeString
{
    WorkPopView *popView = [[[NSBundle mainBundle] loadNibNamed:@"WorkPopView" owner:self options:nil] lastObject];
    popView.type = typeString;
    return popView;
}

- (void)awakeFromNib
{
    self.layer.cornerRadius = 10.0f;
    self.adviceTextView.layer.cornerRadius = 5.0f;
    self.adviceTextView.layer.borderWidth = .5f;
    self.adviceTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    [self addGestureRecognizer:tap];
    
    [self updateConstraints];
}

- (void)showInView:(UIView *)view_
{
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view_.bounds.size.width, view_.bounds.size.height)];
    self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5f];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.maskView addGestureRecognizer:tap];
    
    self.frame = CGRectMake(25.0f, 80.0f, self.bounds.size.width, self.bounds.size.height);
    
    
    if (![self.type isEqualToString:@"askOther"]) {
        self.chooseOtherBtnHeight.constant = 0.0f;
        self.space.constant = 1.0f;
        self.chooseOtherBtn.hidden = YES;
    }
    
    if ([self.type isEqualToString:@"agree"]) {
        self.adviceTextView.text = @"同意";
    }
    
    
    [view_ addSubview:self.maskView];
    
    [view_ addSubview:self];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        CGFloat y = view_.bounds.size.height - 216.0f - self.bounds.size.height;
        
        y = y < 0 ? 0 : y;
        
        self.frame = CGRectMake(25.0f, y, self.bounds.size.width, self.bounds.size.height);

    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        self.frame = CGRectMake(25.0f, 80.0f, self.bounds.size.width, self.bounds.size.height);

    }];
    
    
    [self.adviceTextView becomeFirstResponder];

}

- (void)hide
{
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];

    [self.maskView removeFromSuperview];
    self.maskView = nil;
    
    [self removeFromSuperview];
    
}

- (void)closeKeyBoard
{
    [self.adviceTextView resignFirstResponder];
}

- (IBAction)submit:(id)sender
{
    [SVProgressHUD showWithStatus:@"正在提交"];
    
    //参数
    /*
     token：令牌
     uid：用户名
     orgid: 组织id
     taskid: 任务编号
     action：当前处理动作（前面action的id值）
     other：询问其他人编号（可选，不一定有）
     memo：处理意见
     items：修改的字段（可选，不一定修改，目前没有改）
     */
    
    NSString *memo = self.adviceTextView.text;
    
    if (!memo || !memo.length) {
        [UIAlertView showWithNotice:@"请输入您的处理意见"];
        return;
    }
    
    NSDictionary *para = @{@"action":self.type,
                           @"other":@"",
                           @"memo":memo};
    
    if (self.submitCallBackBlock) {
        self.submitCallBackBlock(para);
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
