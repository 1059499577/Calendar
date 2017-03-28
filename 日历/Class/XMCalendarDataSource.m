//
//  XMCalendarDataSource.m
//  日历
//
//  Created by RenXiangDong on 17/3/28.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMCalendarDataSource.h"

@implementation XMCalendarDataSource

- (NSMutableArray<XMCalendarModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSString *)topTitle {
    return  [NSString stringWithFormat:@"%ld年%ld月",(long)self.year,(long)self.month];
}

@end
