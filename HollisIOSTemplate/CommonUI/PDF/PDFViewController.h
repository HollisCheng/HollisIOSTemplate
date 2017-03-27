//
//  PDFViewController.h
//  ArtisanalLiving
//
//  Created by garyhuang on 16/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import "UIBaseViewController.h"

@interface PDFViewController : UIBaseViewController

@property (strong, nonatomic) NSURL *pdfURL;
//@property (assign, nonatomic) BOOL isInAppBrowser;
@property (assign, nonatomic) BOOL isFromSideMenu;

- (void)initNavBarButtonItem;
- (void)webLoadRequest;

@end
