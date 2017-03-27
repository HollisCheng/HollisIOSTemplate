//
//  InAppBrowserWebViewController.h
//  ArtisanalLiving
//
//  Created by garyhuang on 3/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import <KINWebBrowser/KINWebBrowserViewController.h>

@interface InAppBrowserWebViewController : KINWebBrowserViewController

@property (assign, nonatomic) BOOL isFromSideMenu;
@property (assign, nonatomic) BOOL isShowBottomToolbar;
@property (assign, nonatomic) BOOL isPushViewController;
@property (nonatomic, copy) NSString *webTitle;
@property (nonatomic, copy) NSString *url;

@end
