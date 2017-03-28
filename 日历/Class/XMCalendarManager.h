//
//  XMCalendarManager.h
//  日历
//
//  Created by RenXiangDong on 17/3/28.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMCalendarDataSource.h"

@interface XMCalendarManager : NSObject

- (NSIndexPath *)currentDayIndexPath;

- (XMCalendarDataSource *)currentMonth;

- (XMCalendarDataSource *)nextMonth;

- (XMCalendarDataSource *)preMonth;

- (XMCalendarDataSource *)nextYear;

- (XMCalendarDataSource *)preYear;

@end
