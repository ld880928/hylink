//
//  DateManager.m
//  ganqishi
//
//  Created by jijeMac2 on 14-5-13.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import "DateManager.h"

@interface DateManager()
@property(nonatomic,strong)NSDateFormatter *dateFormater;
@property(nonatomic,strong)NSDateComponents *dateComponets;
@end

@implementation DateManager

+ (DateManager *)sharedManager
{
    static DateManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
        sharedAccountManagerInstance.dateFormater = [[NSDateFormatter alloc] init];
        sharedAccountManagerInstance.dateComponets = [[NSDateComponents alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [sharedAccountManagerInstance.dateFormater setTimeZone:timeZone];

    });
    return sharedAccountManagerInstance;
}

- (NSDate *)dateAndTimeFromStringIncludeSeconds:(NSString *)dateAndTimeStr_
{
    return [self dateForString:dateAndTimeStr_ withFormat:FORMAT_STRING_DATE_TIME];
}

- (NSString *)stringForTimeInterval:(NSTimeInterval)timeInterval_ withFormat:(NSString *)format_
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval_];
    return [self stringForDate:date withFormat:format_];
}

- (NSString *)stringForDate:(NSDate *)date_ withFormat:(NSString *)format_
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format_;
    return [dateFormatter stringFromDate:date_];
}

- (NSDate *)dateForString:(NSString *)dateStr_ withFormat:(NSString *)format_
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format_;
    return [dateFormatter dateFromString:dateStr_];
}

- (NSString *)shortDateToLong:(NSString *)shortDate
{
    NSDate *d = [self dateForString:shortDate withFormat:FORMAT_STRING_DATE];
    return [self stringForDate:d withFormat:FORMAT_STRING_DATE_TIME];
}

@end
