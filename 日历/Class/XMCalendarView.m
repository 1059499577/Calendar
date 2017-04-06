//
//  XMCalendarView.m
//  日历
//
//  Created by RenXiangDong on 17/3/27.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//


#import "XMCalendarView.h"
#import "XMCalendarCell.h"
#import "XMCalendarDataSource.h"
#import "XMCalendarManager.h"

@interface XMCalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) XMCalendarDataSource *dataSourceModel;
@property (nonatomic, strong) XMCalendarManager *calendarManager;

@end
@implementation XMCalendarView

-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"XMCalendarView" owner:self options:nil] lastObject];
        self.frame = frame;
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.dataSourceModel = [self.calendarManager currentMonth];
        self.topTitleLabel.text = self.dataSourceModel.topTitle;
        [self.collectionView registerNib:[UINib nibWithNibName:@"XMCalendarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"XMCalendarCell"];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.collectionViewLayout = self.layout;
        NSIndexPath *todayIndexPath = [self.calendarManager currentDayIndexPath];
        [self.collectionView selectItemAtIndexPath:todayIndexPath animated:YES scrollPosition:(UICollectionViewScrollPositionTop)];
    }
    return self;
}


#pragma mark - CollectionView的代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceModel.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMCalendarModel *model = self.dataSourceModel.dataSource[indexPath.row];
    XMCalendarCell *cell = [XMCalendarCell cellWithCalendarModel:model collectionView:collectionView indexpath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XMCalendarModel *model = self.dataSourceModel.dataSource[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(xmCalendarSelectDate:)]) {
        [self.delegate xmCalendarSelectDate:model.date];
    }
    if ([self.delegate respondsToSelector:@selector(xmCalendarSelectCalendarModel:)]) {
        [self.delegate xmCalendarSelectCalendarModel:model];
    }
}


- (IBAction)preYear:(UIButton *)sender {
    self.dataSourceModel = [self.calendarManager preYear];
    [self.collectionView reloadData];
    self.topTitleLabel.text = self.dataSourceModel.topTitle;
}
- (IBAction)preMonth:(UIButton *)sender {
    self.dataSourceModel = [self.calendarManager preMonth];
    [self.collectionView reloadData];
    self.topTitleLabel.text = self.dataSourceModel.topTitle;
}
- (IBAction)nextMonth:(id)sender {
    self.dataSourceModel = [self.calendarManager nextMonth];
    [self.collectionView reloadData];
    self.topTitleLabel.text = self.dataSourceModel.topTitle;
}
- (IBAction)nextYear:(id)sender {
    self.dataSourceModel = [self.calendarManager nextYear];
    [self.collectionView reloadData];
    self.topTitleLabel.text = self.dataSourceModel.topTitle;
}

#pragma mark - getter & setter
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.itemSize = CGSizeMake(self.bounds.size.width/7.0, 53);
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}

- (XMCalendarManager *)calendarManager {
    if (!_calendarManager) {
        _calendarManager = [[XMCalendarManager alloc] init];
    }
    return _calendarManager;
}


@end
