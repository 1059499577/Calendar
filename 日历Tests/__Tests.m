//
//  __Tests.m
//  日历Tests
//
//  Created by RenXiangDong on 17/3/27.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface __Tests : XCTestCase

@end

@implementation __Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}
/* 清明节日期的计算 [Y*D+C]-L
 公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=4.81，20世纪=5.59。
 清明日期爲4月4日～6日之間。
 举例说明：2088年清明日期=[88×.0.2422+4.81]-[88/4]=26-22=4，4月4日是清明 */
- (NSInteger)getQingMingDayWithYear:(NSInteger)year {
    NSInteger Y = year % 100;
    NSInteger tmpC = year / 1000;
    float C = tmpC == 1?5.59:4.81;
    float D = 0.2422;
    NSInteger L = (year % 100) / 4;
    NSInteger day = (Y * D + C) - L;
    return day;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    NSInteger day = [self getQingMingDayWithYear:2022];
    NSLog(@"卡卡卡%ld",day);
    XCTAssertEqual(day, 5);
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
