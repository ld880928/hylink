//
//  MWorkDetailItem.h
//  hylink
//
//  Created by 李迪 on 14-9-19.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWorkDetailItem : NSObject

@property(nonatomic,assign)BOOL     f_work_detail_item_editable;
@property(nonatomic,strong)NSString *f_work_detail_item_id;
@property(nonatomic,strong)NSString *f_work_detail_item_label;
@property(nonatomic,strong)NSString *f_work_detail_item_type;

@property(nonatomic,strong)NSObject *f_work_detail_item_value;

- (instancetype)initWithDictionary:(id)data_;

@end
