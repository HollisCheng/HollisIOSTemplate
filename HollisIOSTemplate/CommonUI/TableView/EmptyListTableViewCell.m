//
//  EmptyListTableViewCell.m
//  ArtisanalLiving
//
//  Created by devuser cif on 15/11/2016.
//  Copyright © 2016 NWD. All rights reserved.
//

#import "EmptyListTableViewCell.h"

@implementation EmptyListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLbl.textColor = contentColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
