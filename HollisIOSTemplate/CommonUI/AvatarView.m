//
//  AvatarView.m
//  ArtisanalLiving
//
//  Created by devuser cif on 7/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import "AvatarView.h"

@implementation AvatarView

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit {
    self.backgroundColor = [UIColor clearColor];
    [self addCircleCornerRadius];
    
    UIImageView *avatarIV = [[UIImageView alloc] init];
    avatarIV.image = [UIImage imageNamed:@"img_profile_default"];
    [avatarIV setUserInteractionEnabled:YES];
    [avatarIV setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:avatarIV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    [avatarIV addGestureRecognizer:tap];
    
    self.avatarIV = avatarIV;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[avatarIV]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(avatarIV)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[avatarIV]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(avatarIV)]];
}

- (void)imageViewTapped:(id)sender {
    DLog(@"Avatar Tap");
    if (self.avatarDidPress) {
        self.avatarDidPress(sender);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
