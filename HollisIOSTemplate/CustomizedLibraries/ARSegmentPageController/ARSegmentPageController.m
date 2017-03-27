//
//  ARSegmentPageController.m
//  ArtisanalLiving
//
//  Created by garyhuang on 15/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import "ARSegmentPageController.h"
#import "ArrowSegmentedControl.h"

#define kSegmentViewHeight  40

const void* _ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET = &_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET;

@interface ARSegmentPageController () <ArrowSegmentedControlDelegate>

@property (nonatomic, strong) UIView<ARSegmentPageHeaderDelegate> *headerView;
@property (nonatomic, strong) ArrowSegmentedControl *segmentView;
@property (nonatomic, strong) NSMutableArray *controllers;
@property (nonatomic, assign) CGFloat segmentToInset;
@property (nonatomic, weak) UIViewController<ARSegmentPageControllerDelegate> *currentDisplayController;
@property (nonatomic, strong) NSLayoutConstraint *headerHeightConstraint;

@property (nonatomic, strong) NSMutableArray *isSegmentFirstSelectedArray;

@end

@implementation ARSegmentPageController

- (instancetype)initWithControllers:(UIViewController<ARSegmentPageControllerDelegate> *)controller, ... {
    self = [super init];
    if (self) {
        NSAssert(controller != nil, @"the first controller must not be nil!");
        [self setUp];
        UIViewController<ARSegmentPageControllerDelegate> *eachController;
        va_list argumentList;
        if (controller)
        {
            [self.controllers addObject: controller];
            va_start(argumentList, controller);
            while ((eachController = va_arg(argumentList, id)))
            {
                [self.controllers addObject:eachController];
            }
            va_end(argumentList);
        }
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedSegmentIndex = SegmentedControlFirst;
    _isSegmentFirstSelectedArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO], nil];
    [self baseConfigs];
    [self baseLayout];
}

- (void)dealloc {
    [self removeObseverForPageController:self.currentDisplayController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public methods

- (void)setViewControllers:(NSArray *)viewControllers{
    [self.controllers removeAllObjects];
    [self.controllers addObjectsFromArray:viewControllers];
}

#pragma mark - override methods

- (UIView<ARSegmentPageHeaderDelegate> *)customHeaderView {
    return [[ARSegmentPageHeader alloc] init];
}

#pragma mark - private methdos

- (void)setUp {
    self.headerHeight = 200;
    self.segmentHeight = kSegmentViewHeight;
    self.segmentToInset = 200;
    self.segmentMiniTopInset = 0;
    self.controllers = [NSMutableArray array];
}

- (void)baseConfigs {
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([self.view respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.view.preservesSuperviewLayoutMargins = YES;
    }
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.headerView = [self customHeaderView];
    self.headerView.clipsToBounds = YES;
    [self.view addSubview:self.headerView];

    [self.view addSubview:self.segmentView];
    
    //defaut at index 0
    UIViewController<ARSegmentPageControllerDelegate> *controller = self.controllers[0];
    [controller willMoveToParentViewController:self];
    [self.view insertSubview:controller.view atIndex:0];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    
    [self layoutControllerWithController:controller];
    [self addObserverForPageController:controller];
    
    self.currentDisplayController = self.controllers[0];
}

- (void)baseLayout {
    //header
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.headerHeightConstraint = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.headerHeight];
    [self.headerView addConstraint:self.headerHeightConstraint];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    //segment
    self.segmentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    [self.segmentView addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.segmentHeight]];
}

- (void)layoutControllerWithController:(UIViewController<ARSegmentPageControllerDelegate> *)pageController {
    UIView *pageView = pageController.view;
    if ([pageView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        pageView.preservesSuperviewLayoutMargins = YES;
    }
    pageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
    UIScrollView *scrollView = [self scrollViewInPageController:pageController];
    if (scrollView) {
        scrollView.alwaysBounceVertical = YES;
        CGFloat topInset = self.headerHeight+self.segmentHeight;
        //fixed bootom tabbar inset
        CGFloat bottomInset = 0;
//        if (self.tabBarController.tabBar.hidden == NO) {
//            bottomInset = CGRectGetHeight(self.tabBarController.tabBar.bounds);
//        }
        
        [scrollView setContentInset:UIEdgeInsetsMake(topInset, 0, bottomInset, 0)];
        //fixed first time don't show header view
        //        [scrollView setContentOffset:CGPointMake(0, -self.headerHeight-self.segmentHeight)];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    }else{
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.segmentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:-self.segmentHeight]];
    }
    
}

- (UIScrollView *)scrollViewInPageController:(UIViewController <ARSegmentPageControllerDelegate> *)controller {
    if ([controller respondsToSelector:@selector(streachScrollView)]) {
        return [controller streachScrollView];
    }else if ([controller.view isKindOfClass:[UIScrollView class]]){
        return (UIScrollView *)controller.view;
    }else{
        return nil;
    }
}

- (ArrowSegmentedControl *)segmentView {
    if (!_segmentView) {
        UIViewController<ARSegmentPageControllerDelegate> *controller0 = self.controllers[0];
        UIViewController<ARSegmentPageControllerDelegate> *controller1 = self.controllers[1];
        _segmentView = [[ArrowSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSegmentViewHeight) titleArray:[NSArray arrayWithObjects:controller0.segmentTitle, controller1.segmentTitle, nil] titleImageArray:nil];
        _segmentView.delegate = self;
    }
    return _segmentView;
}

#pragma mark - add / remove obsever for page scrollView

- (void)addObserverForPageController:(UIViewController <ARSegmentPageControllerDelegate> *)controller {
    UIScrollView *scrollView = [self scrollViewInPageController:controller];
    if (scrollView != nil) {
        [scrollView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:&_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET];
    }
}

- (void)removeObseverForPageController:(UIViewController <ARSegmentPageControllerDelegate> *)controller {
    UIScrollView *scrollView = [self scrollViewInPageController:controller];
    if (scrollView != nil) {
        @try {
            [scrollView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset))];
        }
        @catch (NSException *exception) {
            NSLog(@"exception is %@",exception);
        }
        @finally {
            
        }
    }
}

#pragma mark - obsever delegate methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (context == _ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET) {
        NSLog(@"offset: %@\nheader: %f\nmini inset = %f", change, self.headerHeightConstraint.constant, self.segmentToInset);
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        CGFloat offsetY = offset.y;
        CGPoint oldOffset = [change[NSKeyValueChangeOldKey] CGPointValue];
        CGFloat oldOffsetY = oldOffset.y;
        CGFloat deltaOfOffsetY = offset.y - oldOffsetY;
        CGFloat offsetYWithSegment = offset.y + self.segmentHeight;
        
        if (deltaOfOffsetY > 0) {
            // 当滑动是向上滑动时
            // 跟随移动的偏移量进行变化
            // NOTE:直接相减有可能constant会变成负数，进而被系统强行移除，导致header悬停的位置错乱或者crash
            if (self.headerHeightConstraint.constant - deltaOfOffsetY <= 0) {
                self.headerHeightConstraint.constant = self.segmentMiniTopInset;
            } else {
                self.headerHeightConstraint.constant -= deltaOfOffsetY;
            }
            // 如果到达顶部固定区域，那么不继续滑动
            if (self.headerHeightConstraint.constant <= self.segmentMiniTopInset) {
                self.headerHeightConstraint.constant = self.segmentMiniTopInset;
            }
        } else {
            // 当向下滑动时
            // 如果列表已经滚动到屏幕上方
            // 那么保持顶部栏在顶部
            if (offsetY > 0) {
                if (self.headerHeightConstraint.constant <= self.segmentMiniTopInset) {
                    self.headerHeightConstraint.constant = self.segmentMiniTopInset;
                }
            } else {
                // 如果列表顶部已经进入屏幕
                // 如果顶部栏已经到达底部
                if (self.headerHeightConstraint.constant >= self.headerHeight) {
                    // 如果当前列表滚到了顶部栏的底部
                    // 那么顶部栏继续跟随变大，否这保持不变
                    if (-offsetYWithSegment > self.headerHeight) {
                        self.headerHeightConstraint.constant = -offsetYWithSegment;
                    } else {
                        self.headerHeightConstraint.constant = self.headerHeight;
                    }
                } else {
                    // 在顶部拦未到达底部的情况下
                    // 如果列表还没滚动到顶部栏底部，那么什么都不做
                    // 如果已经到达顶部栏底部，那么顶部栏跟随滚动
                    if (self.headerHeightConstraint.constant < -offsetYWithSegment) {
                        self.headerHeightConstraint.constant -= deltaOfOffsetY;
                        
                        // if the second segment is also selected/loaded for one time, then need to scroll the tableviews together is scroll down
                        if ([[self.isSegmentFirstSelectedArray objectAtIndex:1] boolValue]) {
                            UIViewController<ARSegmentPageControllerDelegate> *controller0 = self.controllers[0];
                            UIViewController<ARSegmentPageControllerDelegate> *controller1 = self.controllers[1];
                            UIScrollView *scrollView0 = [self scrollViewInPageController:controller0];
                            UIScrollView *scrollView1 = [self scrollViewInPageController:controller1];
                            if (self.selectedSegmentIndex == SegmentedControlFirst) {
                                scrollView1.contentOffset = scrollView0.contentOffset;
                            } else if (self.selectedSegmentIndex == SegmentedControlSecond) {
                                scrollView0.contentOffset = scrollView1.contentOffset;
                            }
                        }
                        
                    }
                }
            }
        }
        // 更新 `segmentToInset` 变量，让外部的 kvo 知道顶部栏位置的变化
        self.segmentToInset = self.headerHeightConstraint.constant;
    }
}

#pragma mark - ArrowSegmentedControlDelegate

- (void)clickArrowSegmentedControl:(NSInteger)selectedIndex {
    
    _selectedSegmentIndex = selectedIndex;
    
    //remove obsever
    [self removeObseverForPageController:self.currentDisplayController];
    
    //add new controller
    NSUInteger index = selectedIndex;
    UIViewController<ARSegmentPageControllerDelegate> *controller = self.controllers[index];
    
    [self.currentDisplayController willMoveToParentViewController:nil];
    [self.currentDisplayController.view removeFromSuperview];
    [self.currentDisplayController removeFromParentViewController];
    [self.currentDisplayController didMoveToParentViewController:nil];
    
    [controller willMoveToParentViewController:self];
    [self.view insertSubview:controller.view atIndex:0];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    
    // reset current controller
    self.currentDisplayController = controller;
    //layout new controller
    [self layoutControllerWithController:controller];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    
    //trigger to fixed header constraint
    UIScrollView *scrollView = [self scrollViewInPageController:controller];
    
    if (![[self.isSegmentFirstSelectedArray objectAtIndex:index] boolValue]) {
        [scrollView setContentOffset:CGPointMake(0, -(self.headerHeight+self.segmentHeight))];
        [self.isSegmentFirstSelectedArray replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:YES]];
    }
    
    if (self.headerHeightConstraint.constant != self.headerHeight) {
        if (scrollView.contentOffset.y >= -(self.segmentHeight + self.headerHeight) && scrollView.contentOffset.y <= -self.segmentHeight) {
            [scrollView setContentOffset:CGPointMake(0, -self.segmentHeight - self.headerHeightConstraint.constant)];
        }
    }
    //add obsever
    [self addObserverForPageController:self.currentDisplayController];
}

@end
