//
//  ARSegmentPageController.h
//  ArtisanalLiving
//
//  Created by garyhuang on 15/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import "UIBaseViewController.h"
#import <UIKit/UIKit.h>
#import "ARSegmentPageHeader.h"

@protocol ARSegmentPageControllerDelegate <NSObject>
- (NSString *)segmentTitle;
@optional
- (UIScrollView *)streachScrollView;
@end

@interface ARSegmentPageController : UIBaseViewController

@property (nonatomic, assign) CGFloat segmentHeight;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat segmentMiniTopInset;
@property (nonatomic, assign, readonly) CGFloat segmentToInset;

@property (nonatomic, assign) NSInteger selectedSegmentIndex;

@property (nonatomic, weak, readonly) UIViewController<ARSegmentPageControllerDelegate> *currentDisplayController;

@property (nonatomic, strong, readonly) UIView<ARSegmentPageHeaderDelegate> *headerView;

- (instancetype)initWithControllers:(UIViewController<ARSegmentPageControllerDelegate> *)controller,... NS_REQUIRES_NIL_TERMINATION;

- (void)setViewControllers:(NSArray *)viewControllers;

//override this method to custom your own header view
- (UIView<ARSegmentPageHeaderDelegate> *)customHeaderView;

@end
