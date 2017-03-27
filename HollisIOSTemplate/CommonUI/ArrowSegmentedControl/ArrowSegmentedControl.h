//
//  ArrowSegmentedControl.h
//  ArtisanalLiving
//
//  Created by Gary on 11/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ArrowSegmentedControlDelegate <NSObject>

- (void)clickArrowSegmentedControl:(NSInteger)selectdIndex;

@end

@interface ArrowSegmentedControl : UIView

@property (assign, nonatomic) id<ArrowSegmentedControlDelegate> delegate;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *titleImageArray;

- (id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray titleImageArray:(NSArray *)titleImageArray;
- (CGRect)changeSelectedButton:(NSInteger)selectIndex isClick:(BOOL)isClick;

- (void)reloadButton;
- (void)eventReloadButtonImage;

@end
