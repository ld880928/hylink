//
//  MWorkDetail.m
//  hylink
//
//  Created by 李迪 on 14-9-19.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "MWorkDetail.h"

@implementation MWorkDetail

- (instancetype)initWithDictionary:(id)data_
{
    if (self = [super init]) {

        NSMutableArray *actions = [NSMutableArray array];
        NSMutableArray *comments = [NSMutableArray array];
        NSMutableArray *formItems = [NSMutableArray array];

        NSArray *actionDatas = [data_ objectForKey:@"actions"];
        NSArray *commentDatas = [data_ objectForKey:@"comments"];
        NSArray *formItemDatas = [data_ objectForKey:@"formItems"];

        for (int i=0; i<actionDatas.count; i++) {
            NSDictionary *action = [actionDatas objectAtIndex:i];
            MWorkDetailAction *mWorkDetailAction = [[MWorkDetailAction alloc] initWithDictionary:action];
            [actions addObject:mWorkDetailAction];
        }
        
        for (int i=0; i<commentDatas.count; i++) {
            NSDictionary *comment = [commentDatas objectAtIndex:i];
            MWorkDetailComment *mWorkDetailComment = [[MWorkDetailComment alloc] initWithDictionary:comment];
            [comments addObject:mWorkDetailComment];
        }
        
        for (int i=0; i<formItemDatas.count; i++) {
            NSDictionary *formItem = [formItemDatas objectAtIndex:i];
            MWorkDetailItem *mWorkDetailItem = [[MWorkDetailItem alloc] initWithDictionary:formItem];
            [formItems addObject:mWorkDetailItem];
        }
        
        self.f_work_detail_actions = actions;
        self.f_work_detail_comments = comments;
        self.f_work_detail_items = formItems;
        
    }
    
    return self;
}

@end
