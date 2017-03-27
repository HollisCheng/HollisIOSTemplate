//
//  ARSegmentPageHeader.h
//  ArtisanalLiving
//
//  Created by garyhuang on 15/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol ARSegmentPageHeaderDelegate <NSObject>

@property UIImageView *imageView;

@end

@interface ARSegmentPageHeader : UIView <ARSegmentPageHeaderDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end
