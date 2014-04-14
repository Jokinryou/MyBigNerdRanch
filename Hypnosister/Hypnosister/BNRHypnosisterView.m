//
//  BNRHypnosisterView.m
//  Hypnosister
//
//  Created by Jokinryou Tsui on 4/11/14.
//  Copyright (c) 2014 Jokinryou Tsui. All rights reserved.
//

#import "BNRHypnosisterView.h"

@implementation BNRHypnosisterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect bounds = self.bounds;

    // Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;

//    // The circle will be the largest that will fit in the view
//    float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);

    // The largest circle will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;

    UIBezierPath *path = [[UIBezierPath alloc] init];

//    // Add an arc to the path at center, with radius of radius,
//    // from 0 to 2*PI radians (a circle)
//    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];

    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {

        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];

        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    }

    // Configure line width to 10 points
    path.lineWidth = 10;

    // Configure the deawing color to light gray
    [[UIColor lightGrayColor] setStroke];

    // Draw the line;
    [path stroke];
}

@end
