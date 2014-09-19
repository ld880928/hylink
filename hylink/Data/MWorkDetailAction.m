//
//  MWorkDetailAction.m
//  hylink
//
//  Created by 李迪 on 14-9-19.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "MWorkDetailAction.h"

@implementation MWorkDetailAction

- (instancetype)initWithDictionary:(id)data_
{
    if (self = [super init]) {
        self.f_work_detail_action_disable = [[data_ objectForKey:@"disable"] boolValue];
        self.f_work_detail_action_id = [data_ objectForKey:@"id"];
        self.f_work_detail_action_label = [data_ objectForKey:@"label"];
        
    }
    
    return self;
}

@end
