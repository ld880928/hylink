//
//  MWorkDetail.h
//  hylink
//
//  Created by 李迪 on 14-9-19.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWorkDetail : NSObject
@property(nonatomic,strong)NSArray *f_work_detail_actions;
@property(nonatomic,strong)NSArray *f_work_detail_comments;
@property(nonatomic,strong)NSArray *f_work_detail_items;

- (instancetype)initWithDictionary:(id)data_;
@end
