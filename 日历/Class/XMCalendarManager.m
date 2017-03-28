//
//  XMCalendarManager.m
//  日历
//
//  Created by RenXiangDong on 17/3/28.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//



#import "XMCalendarManager.h"
#import "XMCalendarTool.h"
#import "XMCalendarDataSource.h"
#import <UIKit/UIKit.h>

@interface XMCalendarManager ()

@property (nonatomic, strong) XMCalendarTool *calendarTool;

@property (nonatomic, strong) NSDate *firstDate;//所选月份第一天
@property (nonatomic, assign) NSInteger firstDayWeak;//第一天所在的星期数
@property (nonatomic, assign) NSInteger numberDayInMonth;//这个月的天数
@property (nonatomic, assign) NSInteger year;//当前年份
@property (nonatomic, assign) NSInteger month;//当前月份

@end
@implementation XMCalendarManager

- (NSIndexPath *)currentDayIndexPath {
    XMCalendarDataSource *dataSourceModel = [self currentMonth];
    for (int i = 0; i<dataSourceModel.dataSource.count; i++) {
        XMCalendarModel *model = dataSourceModel.dataSource[i];
        if ([self.calendarTool isTodayWithDate:model.date]) {
           NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];;
           return indexPath;
        }
    }
    return nil;
}

- (XMCalendarDataSource *)currentMonth {
    self.firstDate = [self.calendarTool getCurrentMonthFirstDate];
    return [self getCurrentCalendarSource];
}

- (XMCalendarDataSource *)nextMonth {
    self.firstDate = [self.calendarTool getNextMonthFirstDateWithDate:self.firstDate];
    return [self getCurrentCalendarSource];
}

- (XMCalendarDataSource *)preMonth {
    self.firstDate = [self.calendarTool getPreMonthFirstDateWithDate:self.firstDate];
    return [self getCurrentCalendarSource];
}

- (XMCalendarDataSource *)nextYear {
    self.firstDate = [self.calendarTool getMonthAfterAYearFirstDateWithDate:self.firstDate];
    return [self getCurrentCalendarSource];
}

- (XMCalendarDataSource *)preYear {
    self.firstDate = [self.calendarTool getMonthBeforeAYearFirstDateWithDate:self.firstDate];
    return [self getCurrentCalendarSource];
}


- (XMCalendarDataSource *)getCurrentCalendarSource {
    self.numberDayInMonth = [self.calendarTool getMonthForDays:self.firstDate];
    self.firstDayWeak = [self.calendarTool getWeakForDate:self.firstDate];
    
    XMCalendarDataSource *dataSourceModel = [[XMCalendarDataSource alloc] init];
    //前面添加一些空的model部位
    [dataSourceModel.dataSource addObjectsFromArray:[self getEmptyCalendarModelWithNumber:self.firstDayWeak - 1]];
    
    NSArray *dateArray = [self.calendarTool getDatesInMonth:self.firstDate];
    for (int i = 0; i< dateArray.count; i++) {
        NSDate *tmpDate = dateArray[i];
        XMCalendarModel *model = [[XMCalendarModel alloc] init];
        model.date = tmpDate;
        model.chinesDateNumber = [self.calendarTool getChineseDateInDate:tmpDate];
        model.chinesDateStr = [self.calendarTool getChineseDayWithNumber:model.chinesDateNumber];
        model.chineseMonth = [self.calendarTool getChineseMonthInDate:tmpDate];
        model.chinesMonthStr = [self.calendarTool getChineseMonthWithMonthNumber:model.chineseMonth];
        model.weakNumber = [self.calendarTool getWeakForDate:tmpDate];
        model.dateNumber = [self.calendarTool getdayIndate:tmpDate];
        model.month = [self.calendarTool getMonthIndate:tmpDate];
        model.holidayName = [self.calendarTool holidayInDate:tmpDate];
        model.isEmpty = NO;
        [dataSourceModel.dataSource addObject:model];
        
    }
    NSInteger lastNumber = 42 - dataSourceModel.dataSource.count;
    [dataSourceModel.dataSource addObjectsFromArray:[self getEmptyCalendarModelWithNumber:lastNumber]];
    
    dataSourceModel.year = [self.calendarTool getYearInDate:self.firstDate];
    dataSourceModel.month = [self.calendarTool getMonthIndate:self.firstDate];
    
    return dataSourceModel;

}

- (NSArray<XMCalendarModel *>*)getEmptyCalendarModelWithNumber:(NSInteger)number {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<number; i++) {
        XMCalendarModel *model = [[XMCalendarModel alloc] init];
        model.isEmpty = YES;
        [array addObject:model];
    }
    return array;
}

#pragma mark - getter & setter;

- (XMCalendarTool *)calendarTool {
    if (!_calendarTool) {
        _calendarTool = [[XMCalendarTool alloc] init];
    }
    return _calendarTool;
}
@end
