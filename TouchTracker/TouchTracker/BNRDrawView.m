//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Jokinryou Tsui on 4/29/14.
//  Copyright (c) 2014 Jokinryou Tsui. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView ()

//@property (nonatomic, strong) BNRLine *currentLine;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong)  NSMutableArray *finishedLines;

@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {

        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;

    }

    return self;
}

- (void)strokeLine:(BNRLine *)line {

    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;

    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];

}

- (void)drawRect:(CGRect)rect {

    // Draw finished lines in black
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines) {
        [self strokeLine:line];
    }

    [[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }

//    if (self.currentLine) {
//        // If there is a line currently being drawn, do it in red
//        [[UIColor redColor] set];
//        [self strokeLine:self.currentLine];
//    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));

    for (UITouch *touch in touches) {

        CGPoint location = [touch locationInView:self];

        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;

        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        self.linesInProgress[key] = line;

    }

//    UITouch *touch = [touches anyObject];
//
//    // Get location of the touch in view's coordinate system
//    CGPoint location = [touch locationInView:self];
//
//    self.currentLine = [[BNRLine alloc] init];
//    self.currentLine.begin = location;
//    self.currentLine.end = location;

    [self setNeedsDisplay];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));

    for (UITouch *touch in touches) {

        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        BNRLine *line = self.linesInProgress[key];

        line.end = [touch locationInView:self];

    }

//    UITouch *touch = [touches anyObject];
//    CGPoint location = [touch locationInView:self];
//
//    self.currentLine.end = location;

    [self setNeedsDisplay];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));

    for (UITouch *touch in touches) {

        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        BNRLine *line = self.linesInProgress[key];

        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];

    }

//    [self.finishedLines addObject:self.currentLine];
//
//    self.currentLine = nil;

    [self setNeedsDisplay];

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));

    for (UITouch *touch in touches) {

        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        [self.linesInProgress removeObjectForKey:key];

    }

    [self setNeedsDisplay];

}

@end
