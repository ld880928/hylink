//
//  HomeTabBarController.m
//  hylink
//
//  Created by 李迪 on 14-9-6.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "HomeTabBarController.h"
#import "CustomTabBarView.h"

@interface HomeTabBarController ()

@end

@implementation HomeTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.customTabBar = [CustomTabBarView customTabBarViewWithSelectAtIndexBlock:^(NSUInteger index) {
        
        self.selectedIndex = index;
        
    }];
    
    self.customTabBar.frame = CGRectMake(0, 0, self.customTabBar.bounds.size.width, self.customTabBar.bounds.size.height);
    
    //超级噁心的办法。。。。。
    for (UIView *v in [self.view subviews]) {
        if ([v isKindOfClass:[UITabBar class]]) {
            
            UITabBar *bar = (UITabBar *)v;
            bar.backgroundImage = [UIImage createImageWithColor:[UIColor clearColor]];
            bar.shadowImage = [UIImage createImageWithColor:[UIColor clearColor]];
            
            [bar addSubview:self.customTabBar];
            
            break;
        }
    }
    
    [self performBlock:^{
        
        [self performSegueWithIdentifier:@"HomeToLoginSegue" sender:self];
        
    } afterDelay:.1f];

}

@end
