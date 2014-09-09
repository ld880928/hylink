//
//  CustomSegmentedControl.m
//  hylink
//
//  Created by 李迪 on 14-9-9.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "CustomSegmentedControl.h"
@interface CustomSegmentedControl()

@end

@implementation CustomSegmentedControl

+ (instancetype)customSegmentedControlWithControls:(NSArray *)controls
{
    CustomSegmentedControl *control = [[CustomSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 46.0f)];
    
    
    
    
    return control;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
