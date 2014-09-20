//
//  MWorkDetailComment.h
//  hylink
//
//  Created by 李迪 on 14-9-19.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWorkDetailComment : NSObject

@property(nonatomic,strong)NSString *f_work_detail_comment_memo;
@property(nonatomic,strong)NSString *f_work_detail_comment_time;
@property(nonatomic,strong)NSString *f_work_detail_comment_people;
@property(nonatomic,strong)NSString *f_work_detail_comment_taskid;
@property(nonatomic,strong)NSString *f_work_detail_comment_taskname;


- (instancetype)initWithDictionary:(id)data_;

@end
