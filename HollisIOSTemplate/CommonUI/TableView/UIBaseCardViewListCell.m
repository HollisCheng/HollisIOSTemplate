//
//  UIBaseCardViewListCell.m
//  ArtisanalLiving
//
//  Created by garyhuang on 19/1/16.
//  Copyright © 2016 NWD. All rights reserved.
//

#import "UIBaseCardViewListCell.h"
#import "EventCardViewListCell.h"

@interface UIBaseCardViewListCell ()

@end

@implementation UIBaseCardViewListCell

- (void)initSubviews {
    [self.contentView addSubview:self.bgCardView];
    [self.bgCardView addSubview:self.photoIV];
//    [self.bgCardView addSubview:self.shadowIV];
//    [self.bgCardView addSubview:self.shadowBottomIV];
    [self.bgCardView addSubview:self.maskView];
    [self.bgCardView addSubview:self.topLeftCornerIndicator];
    [self.bgCardView addSubview:self.bookmarkBtn];
    [self.bgCardView addSubview:self.logoIV];
    [self.bgCardView addSubview:self.titleLabel];
    [self.bgCardView addSubview:self.subTitleLabel];
    [self.bgCardView addSubview:self.dayLabel];
    [self.bgCardView addSubview:self.identityTypeView];
    [self.identityTypeView addSubview:self.identityTypeLbl];
    [self.bgCardView addSubview:self.tagIV];
    [self.bgCardView addSubview:self.viewCountLabel];
    [self.bgCardView addSubview:self.viewCountIV];
    [self.bgCardView addSubview:self.seatCountLabel];
    [self.bgCardView addSubview:self.seatCountIV];
}

- (void)clickBookmark:(id)sender {
    
}

#pragma mark - Factory Method

- (UIView *)bgCardView {
    if (!_bgCardView) {
        double viewHeight = kCardViewHeight;
        if ([self isKindOfClass:[EventCardViewListCell class]]) {
            viewHeight = kEventCardViewHeight;
        }
        _bgCardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, viewHeight)];
        _bgCardView.backgroundColor = [UIColor whiteColor];
//        _bgCardView.layer.cornerRadius = 10;
//        _bgCardView.layer.masksToBounds = YES;
//        _bgCardView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _bgCardView.layer.borderWidth = 0.5;
        _bgCardView.clipsToBounds = YES;
    }
    return _bgCardView;
}

- (UIImageView *)photoIV {
    if (!_photoIV) {
        _photoIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bgCardView.frame.size.width, self.bgCardView.frame.size.height)];
        _photoIV.backgroundColor = [UIColor lightGrayColor];
        [_photoIV setContentMode:UIViewContentModeScaleAspectFill];
        _photoIV.clipsToBounds = YES;
    }
    return _photoIV;
}

- (UIImageView *)shadowIV {
    if (!_shadowIV) {
        _shadowIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bgCardView.frame.size.width, self.bgCardView.frame.size.height)];
        _shadowIV.image = [UIImage imageNamed:@"img_card_shadow"];
        _shadowIV.hidden = YES;
        [_shadowIV setContentMode:UIViewContentModeScaleAspectFill];
        _shadowIV.clipsToBounds = YES;
    }
    return _shadowIV;
}

- (UIImageView *)shadowBottomIV {
    if (!_shadowBottomIV) {
        _shadowBottomIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bgCardView.frame.size.width, self.bgCardView.frame.size.height)];
        _shadowBottomIV.image = [UIImage imageNamed:@"img_card_shadow_bottom"];
        _shadowBottomIV.hidden = YES;
        [_shadowBottomIV setContentMode:UIViewContentModeBottom];
        _shadowBottomIV.clipsToBounds = YES;
    }
    return _shadowBottomIV;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bgCardView.frame.size.width, self.bgCardView.frame.size.height)];
        
        // Create the gradient
        CAGradientLayer *gradient = [CAGradientLayer layer];
        
        // Set colors
        gradient.colors = @[(__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor,
                            (__bridge id)[UIColor clearColor].CGColor,
                            (__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor];
        
//        gradient.locations = @[@(0.1), @(0.5), @(0.9)];
        
        // Set bounds
        gradient.frame = _maskView.bounds;
        
        // Add the gradient to the view
        [_maskView.layer addSublayer:gradient];
        
    }
    return _maskView;
}

- (UIButton *)bookmarkBtn {
    if (!_bookmarkBtn) {
        UIImage *image = [UIImage imageNamed:@"icon_like_full"];
        CGFloat width = image.size.width*2.5;
        CGFloat height = image.size.height*2.5;
        _bookmarkBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        // set the image (here with a size of 32 x 32)
        [_bookmarkBtn setImage:image forState:UIControlStateNormal];
        // just set the frame of the button (here 64 x 64)
        [_bookmarkBtn setFrame:CGRectMake(self.bgCardView.frame.size.width-width, 0, width, height)];
        _bookmarkBtn.useActivityIndicator = YES;
//        [_bookmarkBtn showDebugBorderWithColor:[UIColor redColor] width:1];
        [_bookmarkBtn addTarget:self action:@selector(clickBookmark:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bookmarkBtn;
}

- (UIImageView *)logoIV {
    if (!_logoIV) {
        CGFloat imageDiameter = 45;
        _logoIV = [[UIImageView alloc] init];
        _logoIV.frame = CGRectMake(kContentMargin, kCardViewHeight*3/4-10, imageDiameter, imageDiameter);
        [_logoIV addCircleCornerRadius];
        [_logoIV.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [_logoIV.layer setBorderWidth: 0.5];
        _logoIV.hidden = YES;
        [_logoIV setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _logoIV;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kContentMargin, self.bgCardView.frame.size.height-15-20-kContentMargin, (self.bgCardView.frame.size.width-kContentMargin*2), 20)];
        _titleLabel.numberOfLines = 1;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:SweetSansBold size:16];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), self.bgCardView.frame.size.height-15-kContentMargin, CGRectGetWidth(self.titleLabel.frame), 15)];
        _subTitleLabel.numberOfLines = 1;
        _subTitleLabel.backgroundColor = [UIColor clearColor];
        _subTitleLabel.textColor = [UIColor whiteColor];
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        _subTitleLabel.font = [UIFont fontWithName:RobotoMedium size:13];
    }
    return _subTitleLabel;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.subTitleLabel.frame)+10, self.bgCardView.frame.size.height-13-kContentMargin, 60, 13)];
        _dayLabel.numberOfLines = 1;
        _dayLabel.backgroundColor = [UIColor clearColor];
        _dayLabel.textColor = [UIColor whiteColor];
        _dayLabel.textAlignment = NSTextAlignmentLeft;
        _dayLabel.font = [UIFont fontWithName:RobotoMedium size:10];
    }
    return _dayLabel;
}

- (UIView *)identityTypeView {
    if (!_identityTypeView) {
        _identityTypeView = [[UIView alloc] initWithFrame:CGRectMake(kContentMargin, kContentMargin, 100, 23.3)];
        _identityTypeView.backgroundColor = [UIColor colorWithRed:0.592 green:0.514 blue:0.451 alpha:1.000];
        [_identityTypeView addCornerRadius:3];
    }
    return _identityTypeView;
}

- (UILabel *)identityTypeLbl {
    if (!_identityTypeLbl) {
        _identityTypeLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _identityTypeView.frame.size.width, _identityTypeView.frame.size.height)];
        _identityTypeLbl.textAlignment = NSTextAlignmentCenter;
        _identityTypeLbl.backgroundColor = [UIColor clearColor];
        _identityTypeLbl.font = [UIFont fontWithName:RobotoMedium size:12];
        _identityTypeLbl.textColor = [UIColor whiteColor];
    }
    return _identityTypeLbl;
}

- (UIImageView *)tagIV {
    if (!_tagIV) {
        UIImage *tagImage = [UIImage imageNamed:@"img_tag_soldout"];
        _tagIV = [[UIImageView alloc] init];
        _tagIV.frame = CGRectMake(CGRectGetMaxX(self.identityTypeView.frame)+4, kContentMargin, tagImage.size.width, tagImage.size.height);
        _tagIV.image = tagImage;
    }
    return _tagIV;
}

- (UIImageView *)viewCountIV {
    if (!_viewCountIV) {
        UIImage *viewCountImage = [UIImage imageNamed:@"icon_views_white"];
        _viewCountIV = [[UIImageView alloc] init];
        _viewCountIV.contentMode = UIViewContentModeScaleAspectFit;
        _viewCountIV.frame = CGRectMake(self.bgCardView.frame.size.width-self.viewCountLabel.frame.size.width-viewCountImage.size.width-15, self.bgCardView.frame.size.height-13-kContentMargin, viewCountImage.size.width, 13);
        _viewCountIV.image = viewCountImage;
    }
    return _viewCountIV;
}

- (UILabel *)viewCountLabel {
    if (!_viewCountLabel) {
        _viewCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bgCardView.frame.size.width-25-kContentMargin, self.bgCardView.frame.size.height-13-kContentMargin, 25, 13)];
        _viewCountLabel.backgroundColor = [UIColor clearColor];
        _viewCountLabel.font = [UIFont fontWithName:RobotoMedium size:10];
        _viewCountLabel.textColor = [UIColor whiteColor];
    }
    return _viewCountLabel;
}

- (UIImageView *)seatCountIV {
    if (!_seatCountIV) {
        UIImage *seatCountImage = [UIImage imageNamed:@"icon_people"];
        _seatCountIV = [[UIImageView alloc] init];
        _seatCountIV.contentMode = UIViewContentModeScaleAspectFit;
        _seatCountIV.frame = CGRectMake(self.bgCardView.frame.size.width-self.seatCountLabel.frame.size.width-seatCountImage.size.width-15, self.bgCardView.frame.size.height-15-15-kContentMargin, seatCountImage.size.width, 15);
        _seatCountIV.image = seatCountImage;
        _seatCountIV.hidden = YES;
    }
    return _seatCountIV;
}

- (UILabel *)seatCountLabel {
    if (!_seatCountLabel) {
        _seatCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bgCardView.frame.size.width-80-kContentMargin, self.bgCardView.frame.size.height-15-15-kContentMargin, 80, 15)];
        _seatCountLabel.backgroundColor = [UIColor clearColor];
        _seatCountLabel.font = [UIFont fontWithName:RobotoMedium size:10];
        _seatCountLabel.textColor = [UIColor whiteColor];
        _seatCountLabel.hidden = YES;
    }
    return _seatCountLabel;
}

@end
