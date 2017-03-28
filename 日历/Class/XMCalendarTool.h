//
//  XMCalendarTool.h
//  日历
//
//  Created by RenXiangDong on 17/3/27.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMCalendarTool : NSObject
/* 获取当月天数 */
-(NSInteger)getCurrentMonthForDays;

/* 获得某天所在月的天数 */
-(NSInteger)getMonthForDays:(NSDate*)date;

/* 获取当前月份的第一天*/
-(NSDate *)getCurrentMonthFirstDate;

/* 获取下一个月的第一天*/
-(NSDate *)getNextMonthFirstDateWithDate:(NSDate*)date;

/* 获取上一个月的第一天 */
-(NSDate *)getPreMonthFirstDateWithDate:(NSDate*)date;

/* 获得一天的星期数   Sunday = 1 ... Saturday = 7*/
-(NSInteger)getWeakForDate:(NSDate *)date;


/* 获取下年这一月的第一天 */
-(NSDate *)getMonthAfterAYearFirstDateWithDate:(NSDate*)date;

/* 获取上年这一月的第一天 */
-(NSDate *)getMonthBeforeAYearFirstDateWithDate:(NSDate*)date;

/* 获取这月份所有的date集合 */
- (NSMutableArray<NSDate *>*)getDatesInMonth:(NSDate *)firstDate;

/* 获得一天农历初几 */
- (NSInteger)getChineseDateInDate:(NSDate *)date;

/* 获取一天农历几月 */
- (NSInteger)getChineseMonthInDate:(NSDate *)date;

/* 将数字的初几转为文字形式*/
- (NSString *)getChineseDayWithNumber:(NSInteger)dayNumber;

/* 将数字的农历几月，转为文字形式 */
- (NSString *)getChineseMonthWithMonthNumber:(NSInteger)monthNumber;

/* 获得当天的公历号数 */
- (NSInteger)getdayIndate:(NSDate *)date;

/* 获得当天的公历月数 */
- (NSInteger)getMonthIndate:(NSDate *)date;

/* 获取当天所在的年 */
- (NSInteger)getYearInDate:(NSDate *)date;

/* 获取当天节日名称 */
- (NSString *)holidayInDate:(NSDate *)date;

/* 判断这天是不是今天 */
- (BOOL)isTodayWithDate:(NSDate *)date;

@end
