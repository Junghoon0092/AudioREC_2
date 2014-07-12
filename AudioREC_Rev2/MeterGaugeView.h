//
//  MeterGaugeView.h
//  AudioREC_Rev2
//
//  Created by Jung-Hoon on 2014. 7. 3..
//  Copyright (c) 2014년 Hoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeterGaugeView : UIView
{
    CGImageRef imgGauge;
    double value;
    
}

- (void) drawGaugeBitmap:(CGContextRef)context;
@property double value;

@end
