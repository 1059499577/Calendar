//
//  XMCalendarDataSource.h
//  日历
//
//  Created by RenXiangDong on 17/3/28.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMCalendarModel.h"

@interface XMCalendarDataSource : NSObject

@property (nonatomic, copy) NSString *topTitle;
@property (nonatomic, strong) NSMutableArray<XMCalendarModel*> *dataSource;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;

@end
