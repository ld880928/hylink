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

#define URL_SUB_LOGIN [URL_BASE stringByAppendingString:@"/rest/m/login/doLogin"]

#endif
