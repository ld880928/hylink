//
//  MWorkDetailAction.h
//  hylink
//
//  Created by 李迪 on 14-9-19.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWorkDetailAction : NSObject

@property(nonatomic,assign)BOOL     f_work_detail_action_disable;
@property(nonatomic,strong)NSString *f_work_detail_action_id;
@property(nonatomic,strong)NSString *f_work_detail_action_label;


- (instancetype)initWithDictionary:(id)data_;

@end
