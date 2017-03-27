//
//  UIBaseTableViewFooterView.h
//  ArtisanalLiving
//
//  Created by garyhuang on 7/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIBaseTableViewFooterViewDelegate <NSObject>

- (void)clickTableViewFooterReload;
- (void)clickTableViewFooterLoadMore;

@end

@interface UIBaseTableViewFooterView : UIView

@property (nonatomic, assign) CGFloat originalViewHeight;
@property (assign, nonatomic) id<UIBaseTableViewFooterViewDelegate> delegate;

- (void)showLoadingView;
- (void)hideLoadingView;
- (void)showReloadView;
- (void)showSeparatorLine;
- (void)hideSeparatorLine;
- (void)showLoadMoreButton;
- (void)hideLoadMoreButton;

- (void)reloadLanguage;

@end
