//
//  QRCodeView.m
//  ArtisanalLiving
//
//  Created by devuser cif on 8/12/15.
//  Copyright (c) 2015 NWD. All rights reserved.
//

#import "QRCodeView.h"

@interface QRCodeView ()
@property (nonatomic, weak) UIImageView *qrCodeIV;
@end

@implementation QRCodeView

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
    UIImageView *qrCodeIV = [[UIImageView alloc] init];
    [qrCodeIV setUserInteractionEnabled:YES];
    [qrCodeIV setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:qrCodeIV];
    self.qrCodeIV = qrCodeIV;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[qrCodeIV]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(qrCodeIV)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[qrCodeIV]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(qrCodeIV)]];
    
}

- (void)createQRForString:(NSString *)qrString qrCodeColor:(UIColor *)qrCodeColor bgColor:(UIColor *)bgColor qrCodeWidth:(double)qrCodeWidth{
    
    NSData *stringData = [qrString dataUsingEncoding: NSUTF8StringEncoding];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:stringData forKey:@"inputMessage"];
    
    //Change color
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",filter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:qrCodeColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:bgColor.CGColor],
                             nil];
    
    CIImage *outputImage = colorFilter.outputImage;
    
    CGFloat scale = qrCodeWidth / CGRectGetWidth(outputImage.extent);
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    CIImage *transformImage = [outputImage imageByApplyingTransform:transform];
    
    UIImage *codeImage =[UIImage imageWithCIImage:transformImage];
    
    self.qrCodeIV.image = codeImage;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
