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

- (NSInteger)getQingMingDayWithYear:(NSInteger)year {
    NSInteger Y = year % 100;
    NSInteger tmpC = year / 10000;
    float C = tmpC == 1?5.59:4.81;
    float D = 0.2422;
    NSInteger L = (year % 1000) / 4;
    NSInteger day = (Y * D + C) - L;
    return day;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    NSInteger day = [self getQingMingDayWithYear:2020];
    
    XCTAssertEqual(day, 4);
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
