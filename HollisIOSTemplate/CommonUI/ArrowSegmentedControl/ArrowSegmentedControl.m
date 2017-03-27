//
//  ArrowSegmentedControl.m
//  ArtisanalLiving
//
//  Created by Gary on 11/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import "ArrowSegmentedControl.h"
#import "SegmentArrowView.h"

#define kArrowWidth     13
#define kArrowHeight    5

#define kCentreArrowFrame           CGRectMake((self.frame.size.width/2-kArrowWidth/2), self.frame.size.height, kArrowWidth, kArrowHeight)
#define kFirstSegmentArrowFrame     CGRectMake((self.frame.size.width/2-kArrowWidth)/2, self.frame.size.height, kArrowWidth, kArrowHeight)
#define kSecondSegmentArrowFrame    CGRectMake((self.frame.size.width/2-kArrowWidth)/2+self.frame.size.width/2, self.frame.size.height, kArrowWidth, kArrowHeight)

@interface ArrowSegmentedControl ()

@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;
@property (nonatomic, strong) UIButton *thirdButton;
@property (nonatomic, strong) UIView *dividerView;
@property (nonatomic, strong) UIView *secondDividerView;
@property (nonatomic, strong) SegmentArrowView *arrow;

@end

@implementation ArrowSegmentedControl

- (id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray titleImageArray:(NSArray *)titleImageArray{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleArray = titleArray;
        _titleImageArray = titleImageArray;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self addSubview:self.firstButton];
    if (self.titleArray.count > 1) {
        [self addSubview:self.dividerView];
        [self addSubview:self.secondButton];
        if (self.titleArray.count > 2) {
            [self addSubview:self.secondDividerView];
            [self addSubview:self.thirdButton];
        }
    }
    
    if (self.titleArray.count == 1){
        self.firstButton.userInteractionEnabled = NO;
    }else{
        self.firstButton.userInteractionEnabled = YES;
    }
//    [self addSubview:self.arrow];
}

#pragma mark - Other

- (void)clickButton:(UIButton *)sender {
    if (self.titleArray.count > 1) {
        CGRect rect = [self changeSelectedButton:sender.tag isClick:YES];
        [UIView animateWithDuration:0.1
                              delay:0.0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.arrow.frame = rect;
                         }
                         completion:^(BOOL finished){
                         }];
        if ([self.delegate respondsToSelector:@selector(clickArrowSegmentedControl:)]) {
            [self.delegate clickArrowSegmentedControl:sender.tag];
        }
    }
}

- (CGRect)changeSelectedButton:(NSInteger)selectIndex isClick:(BOOL)isClick {
    CGRect rect = self.arrow.frame;
    if (self.titleArray.count > 1) {
        if (selectIndex == SegmentedControlFirst) {
            _firstButton.backgroundColor = [UIColor clearColor];
            _secondButton.backgroundColor = [UIColor clearColor];
            
            [_firstButton setTitleColor:secondTapBarActiveColor forState:UIControlStateNormal];
            [_secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            NSString *firstImageActiveStr = [NSString stringWithFormat:@"icon_active_%@",[self.titleImageArray objectAtIndex:0]];
            NSString *secondImageInActiveStr = [NSString stringWithFormat:@"icon_inactive_%@",[self.titleImageArray objectAtIndex:1]];
            [_firstButton setImage:[UIImage imageNamed:firstImageActiveStr] forState:UIControlStateNormal];
            [_secondButton setImage:[UIImage imageNamed:secondImageInActiveStr] forState:UIControlStateNormal];
            
            if (self.titleArray.count > 2) {
                _thirdButton.backgroundColor = [UIColor clearColor];
                [_thirdButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                NSString *thirdImageInActiveStr = [NSString stringWithFormat:@"icon_inactive_%@",[self.titleImageArray objectAtIndex:2]];
                [_thirdButton setImage:[UIImage imageNamed:thirdImageInActiveStr] forState:UIControlStateNormal];
            }
            
            rect = kFirstSegmentArrowFrame;
        } else if (selectIndex == SegmentedControlSecond) {
            _firstButton.backgroundColor = [UIColor clearColor];
            _secondButton.backgroundColor = [UIColor clearColor];
            
            [_firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_secondButton setTitleColor:secondTapBarActiveColor forState:UIControlStateNormal];
            
            NSString *secondImageActiveStr = [NSString stringWithFormat:@"icon_active_%@",[self.titleImageArray objectAtIndex:1]];
            NSString *firstImageInActiveStr = [NSString stringWithFormat:@"icon_inactive_%@",[self.titleImageArray objectAtIndex:0]];
            [_firstButton setImage:[UIImage imageNamed:firstImageInActiveStr] forState:UIControlStateNormal];
            [_secondButton setImage:[UIImage imageNamed:secondImageActiveStr] forState:UIControlStateNormal];
            
            if (self.titleArray.count > 2) {
                _thirdButton.backgroundColor = [UIColor clearColor];
                [_thirdButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                NSString *thirdImageInActiveStr = [NSString stringWithFormat:@"icon_inactive_%@",[self.titleImageArray objectAtIndex:2]];
                [_thirdButton setImage:[UIImage imageNamed:thirdImageInActiveStr] forState:UIControlStateNormal];
            }
            
            rect = kSecondSegmentArrowFrame;
        } else if (selectIndex == SegmentedControlThird) {
            _firstButton.backgroundColor = [UIColor clearColor];
            _secondButton.backgroundColor = [UIColor clearColor];
            
            [_firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            NSString *secondImageInActiveStr = [NSString stringWithFormat:@"icon_inactive_%@",[self.titleImageArray objectAtIndex:1]];
            NSString *firstImageInActiveStr = [NSString stringWithFormat:@"icon_inactive_%@",[self.titleImageArray objectAtIndex:0]];
            [_firstButton setImage:[UIImage imageNamed:firstImageInActiveStr] forState:UIControlStateNormal];
            [_secondButton setImage:[UIImage imageNamed:secondImageInActiveStr] forState:UIControlStateNormal];
            
            if (self.titleArray.count > 2) {
                _thirdButton.backgroundColor = [UIColor clearColor];
                [_thirdButton setTitleColor:secondTapBarActiveColor forState:UIControlStateNormal];
                
                NSString *thirdImageActiveStr = [NSString stringWithFormat:@"icon_active_%@",[self.titleImageArray objectAtIndex:2]];
                [_thirdButton setImage:[UIImage imageNamed:thirdImageActiveStr] forState:UIControlStateNormal];
            }
            
            rect = kSecondSegmentArrowFrame;
        }
        if (!isClick) {
            self.arrow.frame = rect;
        }
    }else if (self.titleArray.count == 1){
        if (selectIndex == SegmentedControlFirst) {
            _firstButton.backgroundColor = [UIColor clearColor];
            
            [_firstButton setTitleColor:secondTapBarActiveColor forState:UIControlStateNormal];
            
            NSString *firstImageActiveStr = [NSString stringWithFormat:@"icon_active_%@",[self.titleImageArray objectAtIndex:0]];
            [_firstButton setImage:[UIImage imageNamed:firstImageActiveStr] forState:UIControlStateNormal];
        }
    }
    return rect;
}

#pragma mark - Factory Methods

- (UIButton *)firstButton {
    if (!_firstButton) {
        _firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _firstButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/self.titleArray.count, self.frame.size.height);
        _firstButton.backgroundColor = [UIColor clearColor];
        _firstButton.tag = SegmentedControlFirst;
        [_firstButton setTitle:[self.titleArray objectAtIndex:0] forState:UIControlStateNormal];
        [_firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSString *imageStr = [NSString stringWithFormat:@"icon_active_%@",[self.titleImageArray objectAtIndex:0]];
        [_firstButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        _firstButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        NSString *fontName = RobotoRegular;
        if ([appLanguage() isEqualToString:LANG_EN]) {
            fontName = SweetSansRegular;
        }
        _firstButton.titleLabel.font = [UIFont fontWithName:fontName size:13];
        _firstButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _firstButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//        _firstButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_firstButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstButton;
}

- (UIButton *)secondButton {
    if (!_secondButton) {
        _secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _secondButton.frame = CGRectMake(SCREEN_WIDTH/self.titleArray.count, 0, SCREEN_WIDTH/self.titleArray.count, self.frame.size.height);
        _secondButton.backgroundColor = [UIColor clearColor];
        _secondButton.tag = SegmentedControlSecond;
        [_secondButton setTitle:[self.titleArray objectAtIndex:1] forState:UIControlStateNormal];
        [_secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSString *imageStr = [NSString stringWithFormat:@"icon_active_%@",[self.titleImageArray objectAtIndex:1]];
        [_secondButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        _secondButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        NSString *fontName = RobotoRegular;
        if ([appLanguage() isEqualToString:LANG_EN]) {
            fontName = SweetSansRegular;
        }
        _secondButton.titleLabel.font = [UIFont fontWithName:fontName size:13];
        _secondButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _secondButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//        _secondButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_secondButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secondButton;
}

- (UIButton *)thirdButton {
    if (!_thirdButton) {
        _thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _thirdButton.frame = CGRectMake(SCREEN_WIDTH/self.titleArray.count*2, 0, SCREEN_WIDTH/self.titleArray.count, self.frame.size.height);
        _thirdButton.backgroundColor = [UIColor clearColor];
        _thirdButton.tag = SegmentedControlThird;
        [_thirdButton setTitle:[self.titleArray objectAtIndex:2] forState:UIControlStateNormal];
        [_thirdButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSString *imageStr = [NSString stringWithFormat:@"icon_active_%@",[self.titleImageArray objectAtIndex:2]];
        [_thirdButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        _thirdButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        NSString *fontName = RobotoRegular;
        if ([appLanguage() isEqualToString:LANG_EN]) {
            fontName = SweetSansRegular;
        }
        _thirdButton.titleLabel.font = [UIFont fontWithName:fontName size:13];
        _thirdButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _thirdButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//        _thirdButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_thirdButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thirdButton;
}

- (SegmentArrowView *)arrow {
    if (!_arrow) {
        _arrow = [[SegmentArrowView alloc] initWithFrame:(self.titleArray.count > 1)?kFirstSegmentArrowFrame:kCentreArrowFrame];
        _arrow.tintColor = [UIColor orangeColor];
        _arrow.backgroundColor = [UIColor clearColor];
    }
    return _arrow;
}

- (UIView *)dividerView{
    if (!_dividerView) {
        _dividerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/self.titleArray.count)-1, (self.frame.size.height-self.frame.size.height/2)/2, 1, self.frame.size.height/2)];
        _dividerView.backgroundColor = [UIColor lightGrayColor];
        _dividerView.alpha = 0.5;
    }
    return _dividerView;
}

- (UIView *)secondDividerView{
    if (!_secondDividerView) {
        _secondDividerView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/self.titleArray.count*2, (self.frame.size.height-self.frame.size.height/2)/2, 1, self.frame.size.height/2)];
        _secondDividerView.backgroundColor = [UIColor lightGrayColor];
        _secondDividerView.alpha = 0.5;
    }
    return _secondDividerView;
}

- (void)reloadButton{
    NSString *fontName = RobotoRegular;
    if ([appLanguage() isEqualToString:LANG_EN]) {
        fontName = SweetSansRegular;
    }
    
    [_firstButton setTitle:[self.titleArray objectAtIndex:0] forState:UIControlStateNormal];
    _firstButton.titleLabel.font = [UIFont fontWithName:fontName size:13];
    
    if (self.titleArray.count > 1) {
        [_secondButton setTitle:[self.titleArray objectAtIndex:1] forState:UIControlStateNormal];
        _secondButton.titleLabel.font = [UIFont fontWithName:fontName size:13];
        
        if (self.titleArray.count > 2) {
            [_thirdButton setTitle:[self.titleArray objectAtIndex:2] forState:UIControlStateNormal];
            _thirdButton.titleLabel.font = [UIFont fontWithName:fontName size:13];
        }
    }
}

- (void)eventReloadButtonImage{
    NSString *firstImageActiveStr = [NSString stringWithFormat:@"icon_active_%@",[self.titleImageArray objectAtIndex:0]];
    [_firstButton setImage:[UIImage imageNamed:firstImageActiveStr] forState:UIControlStateNormal];
}

@end
