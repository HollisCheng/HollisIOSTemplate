//
//  UIBaseCardViewListCell.h
//  ArtisanalLiving
//
//  Created by garyhuang on 19/1/16.
//  Copyright © 2016 NWD. All rights reserved.
//

#import "UIBaseTableViewCell.h"

#define kCardViewMargin 1
#define kContentMargin  10
#define kCardViewHeight 180
#define kEventCardViewHeight 220
#define kCardViewListCellHeight (kCardViewHeight+kCardViewMargin)

@interface UIBaseCardViewListCell : UIBaseTableViewCell

@property (strong, nonatomic) UIView *bgCardView;
@property (strong, nonatomic) UIImageView *photoIV;
@property (strong, nonatomic) UIImageView *shadowIV;
@property (strong, nonatomic) UIImageView *shadowBottomIV;
@property (strong, nonatomic) UIView *maskView;
@property (strong, nonatomic) UIView *topLeftCornerIndicator;
@property (strong, nonatomic) UIButton *bookmarkBtn;
@property (strong, nonatomic) UIImageView *logoIV;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UILabel *dayLabel;
@property (strong, nonatomic) UIView *identityTypeView;
@property (strong, nonatomic) UILabel *identityTypeLbl;
@property (strong, nonatomic) UIImageView *viewCountIV;
@property (strong, nonatomic) UILabel *viewCountLabel;
@property (strong, nonatomic) UIImageView *seatCountIV;
@property (strong, nonatomic) UILabel *seatCountLabel;
@property (strong, nonatomic) UIImageView *tagIV;

@end
