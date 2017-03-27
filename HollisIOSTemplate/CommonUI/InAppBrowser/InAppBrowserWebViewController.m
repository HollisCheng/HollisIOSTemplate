//
//  InAppBrowserWebViewController.m
//  ArtisanalLiving
//
//  Created by garyhuang on 3/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import "InAppBrowserWebViewController.h"

@interface InAppBrowserWebViewController ()

@end

@implementation InAppBrowserWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.isPushViewController) {
        UIBarButtonItem *navBarRightButton = [[UIBarButtonItem alloc] initWithTitle:localizedString(@"general_done")
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(dismissInAppBrowser)];
        self.navigationItem.rightBarButtonItem = navBarRightButton;
    }else{
        [self setBackButton];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (![STRING_MANAGER isEmpty:self.webTitle]) {
        self.title = self.webTitle;
        self.showsPageTitleInNavigationBar = NO;
    }
    
    [self loadURLString:self.url];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.isShowBottomToolbar) {
        [self.navigationController setToolbarHidden:YES animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissInAppBrowser {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    if (self.isFromSideMenu) {
        NWD_POST_NOTIF(kOpenSideMenuNotification, nil, nil);
    }
}

@end
