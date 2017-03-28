//
//  XMCalendarModel.h
//  日历
//
//  Created by RenXiangDong on 17/3/27.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMCalendarModel : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL isEmpty;
@property (nonatomic, assign) NSInteger dateNumber;//公历的号数
@property (nonatomic, assign) NSInteger chinesDateNumber;//农历的号数
@property (nonatomic, assign) NSInteger weakNumber;//周几 其中Sunday = 1 Saturday = 7
@property (nonatomic, assign) NSInteger month;//公历的月份
@property (nonatomic, assign) NSInteger chineseMonth;//农历的月份
@property (nonatomic, copy) NSString *chinesDateStr;//农历的初几汉字形式
@property (nonatomic, copy) NSString *chinesMonthStr;//农历的几月汉字形式

@property (nonatomic, copy) NSString *holidayName;//如果当天是节日，则显示节日名，否则为nil



@end
