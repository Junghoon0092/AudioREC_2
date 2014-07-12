//
//  MeterGaugeView.m
//  AudioREC_Rev2
//
//  Created by Jung-Hoon on 2014. 7. 3..
//  Copyright (c) 2014년 Hoon. All rights reserved.
//

#import "MeterGaugeView.h"

@implementation MeterGaugeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    UIImage *img = [UIImage imageNamed:@"gauge.png"];
    imgGauge = CGImageRetain(img.CGImage);

    //    [img release];
    return self;
}

#define GAUGE_WIDTH 70
#define LINE_WIDTH 3
#define STARTANGLE 225
#define ENDANGLE 135

- (void)drawRect:(CGRect)rect
{
    int StartX = self.bounds.size.width / 2 ;
    int StartY = self.bounds.size.height / 2 + 20;
    int newX, newY;
    int newStartX1, newStartX2;
    int newStartY1, newStartY2;
    int newValue, newValue1, newValue2;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawGaugeBitmap:context];
    if (value >= 0.5)
        newValue = ENDANGLE * 2 * (value - 0.5);
    else newValue = STARTANGLE + (360 - STARTANGLE) * 2 * value;
    
    if (newValue - 90 >= 0) newValue1 = newValue - 90 ;
    else newValue1 = newValue - 90 + 360;
    
    if (newValue + 90 <= 360) newValue2 = newValue + 90 ;
    else newValue2 = newValue + 90 - 360;
    
    newX = (int)(sin(newValue * 3.14/180) * GAUGE_WIDTH + StartX);
    newStartX1 = (int)(sin(newValue1 * 3.14/180) * LINE_WIDTH + StartX);
    newStartX2 = (int)(sin(newValue2 * 3.14/180) * LINE_WIDTH + StartX);
    
    newY = (int)(StartY - (cos(newValue * 3.14/180) * GAUGE_WIDTH));
    newStartY1 = (int)(StartY - (cos(newValue1 * 3.14/180) * LINE_WIDTH));
    newStartY2 = (int)(StartY - (cos(newValue2 * 3.14/180) * LINE_WIDTH));

    CGContextSetRGBFillColor(context, 1.0, 0, 0, 1.0);
    CGContextMoveToPoint(context, newStartX1, newStartY1);
    CGContextAddLineToPoint(context, newStartX2, newStartY2);
    CGContextAddLineToPoint(context, newX, newY);
    CGContextAddLineToPoint(context, newStartX1, newStartY1);
    CGContextFillPath(context);
    
}

- (void)drawGaugeBitmap:(CGContextRef)context
{
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToRect(context, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(imgGauge), CGImageGetHeight(imgGauge)), imgGauge);
    CGContextRestoreGState(context);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
