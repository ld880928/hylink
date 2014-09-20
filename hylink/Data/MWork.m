//
//  MWork.m
//  hylink
//
//  Created by colin on 14-9-18.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "MWork.h"

@implementation MWork
- (instancetype)initWithDictionary:(id)data_
{
    if (self = [super init]) {
        self.f_work_taskid = [data_ objectForKey:@"taskid"];
        self.f_work_createtime = [NSString stringWithFormat:@"%@",[data_ objectForKey:@"createtime"]];
        self.f_work_initiator = [data_ objectForKey:@"initiator"];
        self.f_work_processname = [data_ objectForKey:@"processname"];
        self.f_work_icon = [data_ objectForKey:@"typeicon"];
    }
    
    return self;
}
@end
