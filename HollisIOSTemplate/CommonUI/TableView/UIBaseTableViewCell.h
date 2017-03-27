//
//  UIBaseTableViewCell.h
//  ArtisanalLiving
//
//  Created by garyhuang on 7/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBaseTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat contentInsetLeft;
@property (nonatomic, assign) CGFloat contentInsetRight;

@property (nonatomic, strong) NSIndexPath *indexPath;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
