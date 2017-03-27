//
//  UIBaseTableViewFooterView.m
//  ArtisanalLiving
//
//  Created by garyhuang on 7/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import "UIBaseTableViewFooterView.h"

@interface UIBaseTableViewFooterView ()

@property (strong, nonatomic) UIActivityIndicatorView *loadingView;
@property (strong, nonatomic) UIButton *reloadButton;
@property (strong, nonatomic) UIButton *loadMoreButton;
@property (strong, nonatomic) UIView *separatorView;

@end

@implementation UIBaseTableViewFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        /*
         Custom headers and footers do not contain separators below/above them. You'll need to implement the separator yourself in the custom view (or switch to grouped style, which will show the outline of the group above and below it even with a custom header/footer)
         */
        [self addSubview:self.separatorView];
        self.separatorView.hidden = YES;
        
        [self addSubview:self.loadingView];
        _originalViewHeight = frame.size.height;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.loadingView.center = CGPointMake(self.center.x, kBaseTableViewFooterLoadingViewHeight/2);
    self.reloadButton.center = CGPointMake(self.center.x, kBaseTableViewFooterLoadingViewHeight/2);
    self.loadMoreButton.center = CGPointMake(self.center.x, kBaseTableViewFooterLoadingViewHeight/2);
}

#pragma mark - Functions

- (void)showLoadingView {
    [self.reloadButton removeFromSuperview];
    [self addSubview:self.loadingView];
    [self updateHeightForLoadingViewOrReloadView];
}

- (void)hideLoadingView {
    [self.loadingView removeFromSuperview];
    [self updateFrameHeight:self.originalViewHeight];
}

- (void)showReloadView {
    [self.loadingView removeFromSuperview];
    [self addSubview:self.reloadButton];
    [self updateHeightForLoadingViewOrReloadView];
}

- (void)showSeparatorLine {
    self.separatorView.hidden = NO;
}

- (void)hideSeparatorLine {
    self.separatorView.hidden = YES;
}

- (void)showLoadMoreButton {
    [self addSubview:self.loadMoreButton];
    [self updateHeightForLoadingViewOrReloadView];
}

- (void)hideLoadMoreButton {
    [self.loadMoreButton removeFromSuperview];
    [self updateFrameHeight:self.originalViewHeight];
}

- (void)clickReload {
    if ([self.delegate respondsToSelector:@selector(clickTableViewFooterReload)]) {
        [self.delegate clickTableViewFooterReload];
    }
}

- (void)clickLoadMore {
    if ([self.delegate respondsToSelector:@selector(clickTableViewFooterLoadMore)]) {
        [self.delegate clickTableViewFooterLoadMore];
    }
}

- (void)reloadLanguage{
    [_loadMoreButton setTitle:localizedString(@"privileges_more") forState:UIControlStateNormal];
}

#pragma mark - Helper

- (void)updateHeightForLoadingViewOrReloadView {
    [self updateFrameHeight:(self.originalViewHeight+kBaseTableViewFooterLoadingViewHeight)];
}

#pragma mark - Factory Methods

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)] ;
        _separatorView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    }
    return _separatorView;
}

- (UIActivityIndicatorView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _loadingView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [_loadingView setColor:[UIColor blackColor]];
        [_loadingView startAnimating];
    }
    return _loadingView;
}

- (UIButton *)reloadButton {
    if (!_reloadButton) {
//        UIImage *reloadImg = [UIImage imageNamed:@"tableview_reload"];
//        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        //_reloadButton.frame = CGRectMake(0, 0, reloadImg.size.width, reloadImg.size.height);
//        [_reloadButton setBackgroundImage:reloadImg forState:UIControlStateNormal];
//        [_reloadButton addTarget:self action:@selector(clickReload) forControlEvents:UIControlEventTouchUpInside];
        
        
//        _reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        //btnTwo.frame = CGRectMake(40, 140, 240, 30);
//        //[btnTwo setTitle:@"vc2:v1" forState:UIControlStateNormal];
//        [_reloadButton addTarget:self action:@selector(clickReload) forControlEvents:UIControlEventTouchUpInside];
//        [_reloadButton setImage:[UIImage imageNamed:@"tableview_reload"] forState:UIControlStateNormal];
//        //_reloadButton.backgroundColor = [UIColor blueColor];
//        [_reloadButton setBackgroundImage:[UIImage imageNamed:@"tableview_reload"] forState:UIControlStateNormal];
        
        
        _reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //_reloadButton.backgroundColor = [UIColor blueColor];
        _reloadButton.frame = CGRectMake(20, 20, 160.0, 40.0);
        [_reloadButton setTitle:localizedString(@"general_reload") forState:UIControlStateNormal];
        [_reloadButton addTarget:self action:@selector(clickReload) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadButton;
}

- (UIButton *)loadMoreButton {
    if (!_loadMoreButton) {
        _loadMoreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_loadMoreButton setBackgroundImage:[UIImage imageNamed:@"btn_pink"] forState:UIControlStateNormal];
        _loadMoreButton.backgroundColor = themeColor;
        [_loadMoreButton addCornerRadius:5];
        _loadMoreButton.frame = CGRectMake((SCREEN_WIDTH-80)/2, 15, 80, 30);
        [_loadMoreButton setTitle:localizedString(@"privileges_more") forState:UIControlStateNormal];
        [_loadMoreButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        _loadMoreButton.titleLabel.font = [UIFont fontWithName:SweetSansRegular size:15];
        [_loadMoreButton addTarget:self action:@selector(clickLoadMore) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadMoreButton;
}

@end
