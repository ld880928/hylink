//
//  hylinkURLs.h
//  hylink
//
//  Created by 李迪 on 14-9-16.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#ifndef hylink_hylinkURLs_h
#define hylink_hylinkURLs_h

typedef enum
{
    Request_Status_OK=200,
    Request_Status_Fail=500
}Request_Status;

#define URL_BASE @"http://demo.infoship.cn/scms"

/*!
 *  登录接口
 */
#define URL_SUB_LOGIN [URL_BASE stringByAppendingString:@"/rest/m/login/doLogin"]

/*!
 *  找回密码接口
 */
#define URL_SUB_FORGET [URL_BASE stringByAppendingString:@"/rest/m/login/forget"]

/*!
 *  修改密码
 */
#define URL_SUB_Modify_Password [URL_BASE stringByAppendingString:@"/rest/m/login/modify"]

/*!
 *  待办事项列表
 */
#define URL_SUB_WORKING_LIST [URL_BASE stringByAppendingString:@"/rest/m/bpm/todotask/list"]

/*!
 *  待办事项明细
 */
#define URL_SUB_WORKING_DETAIL [URL_BASE stringByAppendingString:@"/rest/m/bpm/todotask/detail"]



#endif
