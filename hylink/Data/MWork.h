//
//  MWork.h
//  hylink
//
//  Created by colin on 14-9-18.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWork : NSObject
@property(nonatomic,strong)NSString *f_work_taskid;
@property(nonatomic,strong)NSString *f_work_createtime;
@property(nonatomic,strong)NSString *f_work_initiator;
@property(nonatomic,strong)NSString *f_work_processname;
@property(nonatomic,strong)NSString *f_work_icon;

- (instancetype)initWithDictionary:(id)data_;

@end
