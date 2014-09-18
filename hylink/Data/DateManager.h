//
//  DateManager.h
//  ganqishi
//
//  Created by jijeMac2 on 14-5-13.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FORMAT_STRING_DATE       @"yyyy-MM-dd"
#define FORMAT_STRING_DATE_TIME  @"yyyy-MM-dd HH:mm:ss"
#define FORMAT_STRING_DATE_NON_P @"yyyyMMdd"
#define FORMAT_STRING_DATE_TIME_M @"yyyy-MM-dd HH:mm"

@interface DateManager : NSObject

+ (DateManager *)sharedManager;

- (NSDate *)dateAndTimeFromStringIncludeSeconds:(NSString *)dateAndTimeStr_;

// basic methods

- (NSString *)stringForTimeInterval:(NSTimeInterval)timeInterval_ withFormat:(NSString *)format_;

- (NSString *)stringForDate:(NSDate *)date_ withFormat:(NSString *)format_;

- (NSDate *)dateForString:(NSString *)dateStr_ withFormat:(NSString *)format_;

- (NSString *)shortDateToLong:(NSString *)shortDate;

@end
