//
//  XMCalendarTool.m
//  日历
//
//  Created by RenXiangDong on 17/3/27.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMCalendarTool.h"
@interface XMCalendarTool()
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSCalendar *chineseClendar;
@property (nonatomic, assign) NSCalendarUnit unit;
@property (nonatomic, strong) NSArray *chineseDateNameArray;
@property (nonatomic, strong) NSArray *chineseMonthNameArray;
@property (nonatomic, strong) NSDictionary *holidayDict;

@end
@implementation XMCalendarTool

/* 当月天数 */
-(NSInteger)getCurrentMonthForDays {
    NSRange range = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}
/* 指定某天所在月份的天数 */
-(NSInteger)getMonthForDays:(NSDate*)date {
    NSInteger monthNum = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    return monthNum;
}
/* 获取当前月份的第一天*/
-(NSDate *)getCurrentMonthFirstDate {
    NSDateComponents *components = [self.calendar components: self.unit fromDate:[NSDate date]];
    components.day = 1;
    NSDate * firstDate =[self.calendar dateFromComponents:components];
    return firstDate;
}
/* 获取下一个月的第一天 */
-(NSDate *)getNextMonthFirstDateWithDate:(NSDate*)date {
    NSDateComponents *components = [self.calendar components: self.unit fromDate:date];
    components.day = 1;
    components.month++;
    NSDate * nextMonthDate =[self.calendar dateFromComponents:components];
    return nextMonthDate;
}
/* 获取上一个月的第一天 */
-(NSDate *)getPreMonthFirstDateWithDate:(NSDate*)date {
    NSDateComponents *components = [self.calendar components: self.unit fromDate:date];
    components.day = 1;
    components.month--;
    NSDate * nextMonthDate =[self.calendar dateFromComponents:components];
    return nextMonthDate;
}

/* 获得该月第一天所在的星期数 */
-(NSInteger)getWeakForDate:(NSDate *)date {
    [self.calendar setFirstWeekday:1];
    NSDateComponents *comps = [self.calendar components:self.unit fromDate:date];
    NSInteger weekday = [comps weekday];
    return weekday;
}

/* 获取下年这一月的第一天 */
-(NSDate *)getMonthAfterAYearFirstDateWithDate:(NSDate*)date {
    NSDateComponents *components = [self.calendar components: self.unit fromDate:date];
    components.day = 1;
    components.year++;
    NSDate * nextMonthDate =[self.calendar dateFromComponents:components];
    return nextMonthDate;
}

/* 获取上年这一月的第一天 */
-(NSDate *)getMonthBeforeAYearFirstDateWithDate:(NSDate*)date {
    NSDateComponents *components = [self.calendar components: self.unit fromDate:date];
    components.day = 1;
    components.year--;
    NSDate * nextMonthDate =[self.calendar dateFromComponents:components];
    return nextMonthDate;
}
/* 获取一个月的所有date的集合 */
- (NSMutableArray<NSDate *>*)getDatesInMonth:(NSDate *)firstDate {
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    NSDateComponents *components = [self.calendar components: self.unit fromDate:firstDate];
    for (int i = 0; i < [self getMonthForDays:firstDate]; i++) {
        components.day = i + 1;
        NSDate * tmpDate =[self.calendar dateFromComponents:components];
        [dateArray addObject:tmpDate];
    }
    return dateArray;
}

/* 获得一天农历初几 */
- (NSInteger)getChineseDateInDate:(NSDate *)date {
    NSDateComponents *localeComp = [self.chineseClendar components:self.unit fromDate:date];
    return localeComp.day;
}

/* 获取一天农历几月 */
- (NSInteger)getChineseMonthInDate:(NSDate *)date {
    NSDateComponents *localeComp = [self.chineseClendar components:self.unit fromDate:date];
    return localeComp.month;
}
/* 将数字的初几转为文字形式*/
- (NSString *)getChineseDayWithNumber:(NSInteger)dayNumber {
    return self.chineseDateNameArray[dayNumber - 1];
}
/* 将数字的农历几月，转为文字形式 */
- (NSString *)getChineseMonthWithMonthNumber:(NSInteger)monthNumber {
    return self.chineseMonthNameArray[monthNumber - 1];
}

/* 获得当天的公历号数 */
- (NSInteger)getdayIndate:(NSDate *)date {
    NSDateComponents *localeComp = [self.calendar components:self.unit fromDate:date];
    return localeComp.day;
}

/* 获得当天的公历月数 */
- (NSInteger)getMonthIndate:(NSDate *)date {
    NSDateComponents *localeComp = [self.calendar components:self.unit fromDate:date];
    return localeComp.month;
}

/* 获取当天所在的年 */
- (NSInteger)getYearInDate:(NSDate *)date {
    NSDateComponents *localeComp = [self.calendar components:self.unit fromDate:date];
    return localeComp.year;
}

/* 获取当天节日名称 */
- (NSString *)holidayInDate:(NSDate *)date {
    NSInteger day = [self getdayIndate:date];
    NSInteger month = [self getMonthIndate:date];
    NSString *holidayKey = [NSString stringWithFormat:@"%ld-%ld",month,day];
    NSString *holidayName = [self.holidayDict objectForKey:holidayKey];
    if (holidayName) {
        return holidayName;
    }
    //由于清明节比较特殊，需要特殊判断
    if (month == 4 && (day == 4 || day == 5)) {
        NSInteger year = [self getYearInDate:date];
        NSInteger QingMingDay = [self getQingMingDayWithYear:year];
        if (QingMingDay == day) {
            return @"清明节";
        }
    }
    
    NSInteger chineseDay = [self getChineseDateInDate:date];
    NSInteger chineseMonth = [self getChineseMonthInDate:date];
    NSString *chinesHolidayKey = [NSString stringWithFormat:@"%ld/%ld",chineseMonth,chineseDay];
    holidayName = [self.holidayDict objectForKey:chinesHolidayKey];
    
    return holidayName;
}
/* 判断这天是不是今天 */
- (BOOL)isTodayWithDate:(NSDate *)date {
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"YYYY-MM-DD"];
    NSString *todayStr = [formate stringFromDate:[NSDate date]];
    NSString *dateStr = [formate stringFromDate:date];
    return [todayStr isEqualToString:dateStr];
}
/* 清明节日期的计算 [Y*D+C]-L
 公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=4.81，20世纪=5.59。
 清明日期爲4月4日～6日之間。
 举例说明：2088年清明日期=[88×.0.2422+4.81]-[88/4]=26-22=4，4月4日是清明 */
- (NSInteger)getQingMingDayWithYear:(NSInteger)year {
    NSInteger Y = year % 100;
    NSInteger tmpC = year / 10000;
    float C = tmpC == 1?5.59:4.81;
    float D = 0.2422;
    NSInteger L = (year % 1000) / 4;
    NSInteger day = (Y * D + C) - L;
    return day;
}

#pragma mark - setter & getter
- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}

- (NSCalendar *)chineseClendar {
    if (!_chineseClendar) {
        _chineseClendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    }
    return _chineseClendar;
}

-(NSCalendarUnit)unit {
    if (!_unit) {
        _unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;
    }
    return _unit;
}
- (NSArray *)chineseDateNameArray {
    if (!_chineseDateNameArray) {
        _chineseDateNameArray = @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",@"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"];
    }
    return _chineseDateNameArray;
}

- (NSArray *)chineseMonthNameArray {
    if (!_chineseMonthNameArray) {
        _chineseMonthNameArray = @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"冬月", @"腊月"];
    }
    return _chineseMonthNameArray;
}

- (NSDictionary *)holidayDict {
    if (!_holidayDict) {
        _holidayDict = @{@"1-1":@"元旦",
                         @"1/1":@"春节",
                         @"1/15":@"元宵节",
                         @"3-8":@"妇女节",
                         @"5-1":@"劳动节",
                         @"6-1":@"儿童节",
                         @"5-4":@"青年节",
                         @"10-1":@"国庆节",
                         @"5/5":@"端午节",
                         @"7-1":@"建党节",
                         @"8-1":@"建军节",
                         @"8/15":@"中秋节",
                         @"9/9":@"重阳节"};
    }
    return _holidayDict;
}

@end
