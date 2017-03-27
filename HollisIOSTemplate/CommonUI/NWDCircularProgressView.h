//
//  NWDCircularProgressView.h
//  ArtisanalLiving
//
//  Created by devuser cif on 18/1/16.
//  Copyright © 2016 NWD. All rights reserved.
//

#import "DACircularProgressView.h"

@interface NWDCircularProgressView : DACircularProgressView
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, assign) BOOL isHappening;
@property (nonatomic, assign) BOOL isLessThanOneDay;

- (void)progressChange;

@end
