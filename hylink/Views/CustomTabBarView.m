//
//  CustomTabBarView.m
//  hylink
//
//  Created by 李迪 on 14-9-6.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "CustomTabBarView.h"
#import "CustomTabBarItem.h"

@interface CustomTabBarView()
@property(nonatomic,strong)NSMutableArray *items;
@end

@implementation CustomTabBarView

+ (instancetype)customTabBarViewWithSelectAtIndexBlock:(void (^)(NSUInteger))selectAtIndexBlock_
{
    static CustomTabBarView *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[NSBundle mainBundle] loadNibNamed:@"CustomTabBarView" owner:self options:nil] lastObject];
        instance.selectAtIndexBlock = selectAtIndexBlock_;
        instance.items = [NSMutableArray array];
        
        NSArray *tabDatas = @[@{@"normalImageName": @"tab_work_normal",@"selectedImageName":@"tab_work_selected"},
                              @{@"normalImageName": @"tab_news_normal",@"selectedImageName":@"tab_news_selected"},
                              @{@"normalImageName": @"tab_personal_normal",@"selectedImageName":@"tab_personal_selected"},
                              @{@"normalImageName": @"tab_setting_normal",@"selectedImageName":@"tab_setting_selected"}];
        
        for (int i=0;i<tabDatas.count;i++) {
            
            NSDictionary *tabData = [tabDatas objectAtIndex:i];
            
            CustomTabBarItem *item = [CustomTabBarItem customTabBarItemWith:[tabData objectForKey:@"normalImageName"]
                                                          selectedImageName:[tabData objectForKey:@"selectedImageName"]];
            item.tag = i;
            
            
            CGFloat width = instance.bounds.size.width / tabDatas.count;
            
            item.frame = CGRectMake(width * i, 1.0f, width, 48.0f);
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:instance action:@selector(didSelectTab:)];

            [item addGestureRecognizer:tap];
            
            [instance addSubview:item];
            
            [instance.items addObject:item];
            
            if (!i) {
                item.isSelected = YES;
            }
        }
        
    });
    
    return instance;
}

- (void)didSelectTab:(UIGestureRecognizer *)ges
{
    CustomTabBarItem *item = (CustomTabBarItem *)ges.view;
    for (CustomTabBarItem *item_ in self.items) {
        if (item == item_) {
            item_.isSelected = YES;
        }
        else
        {
            item_.isSelected = NO;
        }
    }
    
    if (self.selectAtIndexBlock) {
        self.selectAtIndexBlock(item.tag);
    }
    
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
