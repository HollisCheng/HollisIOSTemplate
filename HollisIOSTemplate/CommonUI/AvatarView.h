//
//  AvatarView.h
//  ArtisanalLiving
//
//  Created by devuser cif on 7/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarView : UIView
@property (nonatomic, weak) UIImageView *avatarIV;

@property (nonatomic, copy) void (^avatarDidPress)(id sender);
@end
