//
//  CustomTabBarItem.m
//  hylink
//
//  Created by 李迪 on 14-9-6.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "CustomTabBarItem.h"

@interface CustomTabBarItem()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTab;

@property (nonatomic,strong)NSString *normalImageName;
@property (nonatomic,strong)NSString *selectedImageName;

@end

@implementation CustomTabBarItem

+ (instancetype)customTabBarItemWith:(NSString *)normalImageName_
                   selectedImageName:(NSString *)selectedImageName_
{
    CustomTabBarItem *item = [[[NSBundle mainBundle] loadNibNamed:@"CustomTabBarItem" owner:self options:nil] lastObject];
    item.normalImageName = normalImageName_;
    item.selectedImageName = selectedImageName_;
    item.isSelected = NO;
    
    item.imageViewTab.image = [UIImage imageNamed:item.normalImageName];
    
    [item addObserver:item forKeyPath:@"isSelected" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];

    
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
                self.imageViewTab.image = [UIImage imageNamed:self.selectedImageName];
            }
            else
            {
                //反选
                self.imageViewTab.image = [UIImage imageNamed:self.normalImageName];
            }
        }

        
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
