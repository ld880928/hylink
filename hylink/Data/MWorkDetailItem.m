//
//  MWorkDetailItem.m
//  hylink
//
//  Created by 李迪 on 14-9-19.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "MWorkDetailItem.h"

@implementation MWorkDetailItem

- (instancetype)initWithDictionary:(id)data_
{
    if (self = [super init]) {
        self.f_work_detail_item_editable = [[data_ objectForKey:@"editable"] boolValue];
        self.f_work_detail_item_id = [data_ objectForKey:@"id"];
        self.f_work_detail_item_label = [data_ objectForKey:@"label"];
        self.f_work_detail_item_type = [data_ objectForKey:@"type"];
        self.f_work_detail_item_value = [data_ objectForKey:@"value"];
    }
    
    return self;
}

@end
