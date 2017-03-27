//
//  QRCodeView.h
//  ArtisanalLiving
//
//  Created by devuser cif on 8/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeView : UIView
- (void)createQRForString:(NSString *)qrString qrCodeColor:(UIColor *)qrCodeColor bgColor:(UIColor *)bgColor qrCodeWidth:(double)qrCodeWidth;
@end
