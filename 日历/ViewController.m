//
//  ViewController.m
//  日历
//
//  Created by RenXiangDong on 17/3/27.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//
#define kScrrenWidth [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "XMCalendarView.h"

@interface ViewController ()<XMCalendarViewDelegate>
@property (nonatomic, strong) XMCalendarView *calendarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.calendarView];
    self.calendarView.delegate =self;
}

- (void)xmCalendarSelectDate:(NSDate *)date {
     NSLog(@"%@",date);
}

- (void)xmCalendarSelectCalendarModel:(XMCalendarModel *)calendarModel {
    
    NSLog(@"%@",calendarModel);
}

-(XMCalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView= [[XMCalendarView alloc] initWithFrame:CGRectMake(10, 100, kScrrenWidth - 20, 400)];
    }
    return _calendarView;
}

@end
