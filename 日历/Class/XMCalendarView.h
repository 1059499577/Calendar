//
//  XMCalendarView.h
//  日历
//
//  Created by RenXiangDong on 17/3/27.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "XMCalendarDataSource.h"

@protocol XMCalendarViewDelegate <NSObject>

- (void)xmCalendarSelectDate:(NSDate *)date;

- (void)xmCalendarSelectCalendarModel:(XMCalendarModel *)calendarModel;

@end

@interface XMCalendarView : UIView

@property (nonatomic, weak)id<XMCalendarViewDelegate>delegate;

@end
