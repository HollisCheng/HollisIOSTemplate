//
//  PDFViewController.m
//  ArtisanalLiving
//
//  Created by garyhuang on 16/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import "PDFViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface PDFViewController () <UIWebViewDelegate, NJKWebViewProgressDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;
@property (strong, nonatomic) NJKWebViewProgress *progressProxy;

@end

@implementation PDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPDF];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    if (!self.isInAppBrowser) {
        [self setNavBarBackgroundImageAlpha:1.0];
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
        
        self.navigationController.navigationBar.translucent = NO;
//    }else{
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"e3e2e7" alpha:1.0] size:CGSizeMake(SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT+STATUS_BAR_HEIGHT)] forBarMetrics:UIBarMetricsDefault];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavBarButtonItem{
    UIBarButtonItem *navBarRightButton = [[UIBarButtonItem alloc] initWithTitle:localizedString(@"general_cancel")
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(dismiss)];
    navBarRightButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = navBarRightButton;
}

- (void)dismiss {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    if (self.isFromSideMenu) {
        NWD_POST_NOTIF(kOpenSideMenuNotification, nil, nil);
    }
}

- (void)loadPDF {

    [self.view addSubview:self.webView];
    _webView.delegate = self.progressProxy;
    [self.webView addSubview:self.progressView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_webView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_webView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_webView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_webView)]];
    [self.webView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_progressView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressView)]];
    [self.webView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_progressView(==3)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressView)]];
    
    [self webLoadRequest];
}

- (void)webLoadRequest{
    NSURLRequest *request = [NSURLRequest requestWithURL:self.pdfURL];
    [_webView loadRequest:request];
}

#pragma mark - Web view delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([STRING_MANAGER isEmpty:self.title]) {
        NSString *webViewTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.title = webViewTitle;
        [self initNavBarTitle:webViewTitle];
    }
}

#pragma mark - NJKWebViewProgressDelegate

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_progressView setProgress:progress animated:YES];
}

#pragma mark - Factory Methods

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
        [_webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _webView;
}

- (NJKWebViewProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[NJKWebViewProgressView alloc] init];
        [_progressView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _progressView;
}

- (NJKWebViewProgress *)progressProxy {
    if (!_progressProxy) {
        _progressProxy = [[NJKWebViewProgress alloc] init];
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
    }
    return _progressProxy;
}

@end
