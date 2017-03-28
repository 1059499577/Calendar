//
//  XMCalendarCell.m
//  日历
//
//  Created by RenXiangDong on 17/3/27.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMCalendarCell.h"

@interface XMCalendarCell ()
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *lunarLabel;

@end
@implementation XMCalendarCell

+ (instancetype)cellWithCalendarModel:(XMCalendarModel *)model collectionView:(UICollectionView *)collectionVeiw indexpath:(NSIndexPath *)indexPath{
    static NSString *ID = @"XMCalendarCell";
    XMCalendarCell *cell = [collectionVeiw dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.layer.cornerRadius = 4;
    cell.layer.masksToBounds = YES;
    cell.model = model;
    return cell;
}
- (void)setModel:(XMCalendarModel *)model {
    if (model.isEmpty) {
        self.dayLabel.hidden = YES;
        self.lunarLabel.hidden = YES;
        self.userInteractionEnabled = NO;
    } else {
        self.dayLabel.hidden = NO;
        self.lunarLabel.hidden = NO;
        self.userInteractionEnabled = YES;
        self.dayLabel.text = [NSString stringWithFormat:@"%ld",model.dateNumber];
        if (model.holidayName != nil) {
            self.lunarLabel.text = model.holidayName;
        } else if (model.chinesDateNumber == 1) {
            self.lunarLabel.text = model.chinesMonthStr;
        } else {
            self.lunarLabel.text = model.chinesDateStr;
        }
    }
}
- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.backgroundColor = [UIColor colorWithRed:48/255.0 green:194/255.0 blue:0 alpha:1];
        self.dayLabel.textColor = [UIColor whiteColor];
        self.lunarLabel.textColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
        self.dayLabel.textColor = [UIColor blackColor];
        self.lunarLabel.textColor = [UIColor blackColor];
    }
}


@end
