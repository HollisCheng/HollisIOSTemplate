//
//  NWDCircularProgressView.m
//  ArtisanalLiving
//
//  Created by devuser cif on 18/1/16.
//  Copyright © 2016 NWD. All rights reserved.
//

#import "NWDCircularProgressView.h"

#define kOneDaySecond   86400 //24*60*60

@interface NWDCircularProgressView ()
@property (nonatomic, weak) UILabel *timeLbl;
@property (nonatomic, weak) UILabel *startLbl;
@end

@implementation NWDCircularProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}


#pragma mark - Internal methods

/**
 Creates and initializes
 -[DALabeledCircularProgressView progressLabel].
 */
- (void)commonInit
{
    self.roundedCorners = YES;
    self.trackTintColor = [UIColor colorWithRed:0.878 green:0.867 blue:0.867 alpha:1.000];
    self.progressTintColor = pendingStatusColor;
    self.thicknessRatio = 0.15;
    self.clockwiseProgress = 0;
    [self setProgress:0 animated:NO];
    
    UIView *centerTxtView = [[UILabel alloc] init];
    centerTxtView.backgroundColor = [UIColor clearColor];
    [centerTxtView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:centerTxtView];
    
    UILabel *timeLbl = [[UILabel alloc] init];
    timeLbl.text = @"12hr 30m";
    timeLbl.textColor = pendingStatusColor;
    timeLbl.font = [UIFont fontWithName:RobotoMedium size:25];
    timeLbl.textAlignment = NSTextAlignmentCenter;
    [timeLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [centerTxtView addSubview:timeLbl];
    self.timeLbl = timeLbl;
    
    UILabel *startLbl = [[UILabel alloc] init];
    startLbl.text = localizedString(@"facilities_to_start");
    startLbl.font = [UIFont fontWithName:RobotoMedium size:12];
    startLbl.textColor = contentColor;
    startLbl.textAlignment = NSTextAlignmentCenter;
    [startLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [centerTxtView addSubview:startLbl];
    self.startLbl = startLbl;
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem: centerTxtView
                                                      attribute: NSLayoutAttributeCenterY
                                                      relatedBy: 0
                                                         toItem: self
                                                      attribute: NSLayoutAttributeCenterY
                                                     multiplier: 1
                                                       constant: 0]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[centerTxtView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(centerTxtView)]];
    [centerTxtView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[timeLbl]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(timeLbl)]];
    [centerTxtView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[startLbl]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(startLbl)]];
    [centerTxtView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[timeLbl]-(-4)-[startLbl]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(timeLbl, startLbl)]];
}

- (void)setIsHiddenCircle:(BOOL)isHiddenCircle{
    if (isHiddenCircle) {
        self.trackTintColor = [UIColor clearColor];
        self.progressTintColor = [UIColor clearColor];

    }else{
        self.trackTintColor = [UIColor colorWithRed:0.878 green:0.867 blue:0.867 alpha:1.000];
        self.progressTintColor = pendingStatusColor;

    }
}

- (NSString *)timeLeft:(NSTimeInterval)seconds{
    int hours = (int)seconds / 3600;             // integer division to get the hours part
    int minutes = (seconds - (hours*3600)) / 60; // interval minus hours part (in seconds) divided by 60 yields minutes
    NSString *timeDiff = [NSString stringWithFormat:@"%dhr %02dm", hours, minutes];
//    DLog(@"time left:%@",timeDiff);
    return timeDiff;
}

- (void)progressChange{
//    DLog(@"current progress:%f",self.progress);
    
    if (self.progress == 1) {
        self.isHappening = YES;
        return;
    }else{
        self.isHappening = NO;
    }
    
    NSTimeInterval timeLeftSecond = [self.startDate timeIntervalSinceDate:[NSDate date]];
    
    if (timeLeftSecond >= kOneDaySecond) {
        //hidden circle progress
        self.isLessThanOneDay = NO;
        [self setIsHiddenCircle:YES];
        self.timeLbl.font = [UIFont fontWithName:RobotoMedium size:60];
        self.timeLbl.textColor = [UIColor colorWithRed:0.396 green:0.502 blue:0.561 alpha:1.000];
        
        int days = (int) (timeLeftSecond / (24 * 60 * 60));
        
        NSString *dayStr = localizedString(@"facilities_day");
        if(days>1 && [appLanguage() isEqualToString:LANG_EN]){
            dayStr = [dayStr stringByAppendingString:@"s"];
        }
        NSMutableAttributedString *attributedstring = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d%@", days, dayStr]];
        if ([appLanguage() isEqualToString:LANG_EN]) {
            if (days>1) {
                [attributedstring addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoMedium size:11] range:NSMakeRange(attributedstring.length-4, 4)];
            }else{
                [attributedstring addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoMedium size:11] range:NSMakeRange(attributedstring.length-3, 3)];
            }
        }else{
            [attributedstring addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoMedium size:11] range:NSMakeRange(attributedstring.length-1, 1)];
        }
        
        self.timeLbl.attributedText = attributedstring;
    }else{
        self.isLessThanOneDay = YES;
        [self setIsHiddenCircle:NO];
        self.timeLbl.font = [UIFont fontWithName:RobotoMedium size:25];
        self.timeLbl.textColor = pendingStatusColor;
        
        NSMutableAttributedString *attributedstring;
        if (timeLeftSecond < 0) {
            attributedstring = [[NSMutableAttributedString alloc] initWithString:@"0hr 00m"];
            
            [self setProgress:1 animated:NO];
            self.isHappening = YES;
        }else{
            attributedstring = [[NSMutableAttributedString alloc] initWithString:[self timeLeft:timeLeftSecond]];
            
            double progress1 = kOneDaySecond-timeLeftSecond;
            double progress2 = progress1/kOneDaySecond;
            CGFloat progress =  progress2;
            [self setProgress:progress animated:NO];
        }
        [attributedstring addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoMedium size:11] range:NSMakeRange(attributedstring.length-1, 1)];
        [attributedstring addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoMedium size:11] range:NSMakeRange(attributedstring.length-5-1, 3)];
        self.timeLbl.attributedText = attributedstring;
    }
}



@end
