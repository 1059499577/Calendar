//
//  XMCalendarCell.h
//  日历
//
//  Created by RenXiangDong on 17/3/27.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMCalendarModel.h"
@interface XMCalendarCell : UICollectionViewCell
@property (nonatomic, strong) XMCalendarModel *model;

+(instancetype)cellWithCalendarModel:(XMCalendarModel *)model collectionView:(UICollectionView *)collectionVeiw indexpath:(NSIndexPath *)indexPath;

@end
