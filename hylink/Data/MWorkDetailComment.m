//
//  MWorkDetailComment.m
//  hylink
//
//  Created by 李迪 on 14-9-19.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "MWorkDetailComment.h"

@implementation MWorkDetailComment

- (instancetype)initWithDictionary:(id)data_
{
    if (self = [super init]) {
        self.f_work_detail_comment_memo = [data_ objectForKey:@"dealMemo"];
        self.f_work_detail_comment_time = [data_ objectForKey:@"dealedAt"];
        self.f_work_detail_comment_people = [data_ objectForKey:@"dealedPeople"];
        self.f_work_detail_comment_taskid = [data_ objectForKey:@"taskId"];
        self.f_work_detail_comment_taskname = [data_ objectForKey:@"taskName"];
    }
    
    return self;
}
@end
