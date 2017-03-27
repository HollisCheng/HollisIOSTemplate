//
//  UIBaseTableViewCell.m
//  ArtisanalLiving
//
//  Created by garyhuang on 7/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import "UIBaseTableViewCell.h"

@implementation UIBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryView = nil;
        [self initSubviews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initSubviews {

}

@end
