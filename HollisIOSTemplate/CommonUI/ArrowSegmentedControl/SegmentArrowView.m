//
//  SegmentArrowView.m
//  ArtisanalLiving
//
//  Created by garyhuang on 18/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import "SegmentArrowView.h"

@implementation SegmentArrowView

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // mid right
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect)/2, CGRectGetMaxY(rect));  // bottom left
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextFillPath(ctx);
}

@end
