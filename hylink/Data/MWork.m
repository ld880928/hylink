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
        
        long time = [[data_ objectForKey:@"createtime"] longValue];
        self.f_work_createtime = [[DateManager sharedManager] stringForTimeInterval:time withFormat:FORMAT_STRING_DATE_TIME_M];
        
        self.f_work_initiator = [data_ objectForKey:@"initiator"];
        self.f_work_processname = [data_ objectForKey:@"processname"];
    }
    
    return self;
}
@end
