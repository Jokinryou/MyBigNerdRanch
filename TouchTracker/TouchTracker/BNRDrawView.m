//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Jokinryou Tsui on 4/29/14.
//  Copyright (c) 2014 Jokinryou Tsui. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;

//@property (nonatomic, strong) BNRLine *currentLine;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong)  NSMutableArray *finishedLines;

@property (nonatomic, weak) BNRLine *selectedLine;

@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {

        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;

        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = YES;

        [self addGestureRecognizer:doubleTapRecognizer];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapGestureRecognizer.delaysTouchesBegan = YES;
        [tapGestureRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapGestureRecognizer];

        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPressGestureRecognizer];

        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];

    }

    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
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

    if (self.selectedLine) {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine];
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

- (BNRLine *)lineAtPoint:(CGPoint)point {

    // Find a line close to point
    for (BNRLine *line in self.finishedLines) {

        CGPoint start = line.begin;
        CGPoint end = line.end;

        // Check a few points on the line
        for (float t = 0.0; t <= 1.0; t += 0.05) {

            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);

            // If the tapped point is within 20 points, let's return this line
            if (hypot(x - point.x, y - point.y) < 20.0) {
                return line;
            }

        }

    }

    // If nothing is close enough to the tapped point, then we did not select a line
    return nil;

}

#pragma mark - Actions

- (void)doubleTap:(UIGestureRecognizer *)gestureRecognizer {

    NSLog(@"Recognized Double Tap");

    [self.linesInProgress removeAllObjects];
//    [self.finishedLines removeAllObjects];
    
    self.finishedLines = [[NSMutableArray alloc] init];
    
    [self setNeedsDisplay];

}

- (void)tap:(UIGestureRecognizer *)gestureRecognizer {

    NSLog(@"Recognized tap");

    CGPoint point = [gestureRecognizer locationInView:self];
    self.selectedLine = [self lineAtPoint:point];

    if (self.selectedLine) {

        // Make ourselves the target of menu item action message
        [self becomeFirstResponder];

        // Grab the menu controller
        UIMenuController *menuController = [UIMenuController sharedMenuController];

        // Create a new "Delete" UIMenuItem
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];

        menuController.menuItems = @[deleteItem];

        // Tell the menu where it should come from and show it
        [menuController setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menuController setMenuVisible:YES animated:YES];

    } else {

        // Hide the menu if no line is selected
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];

    }

    [self setNeedsDisplay];

}

- (void)deleteLine:(id)sender {

    // Remove the selected line from the list of _finishedLines
    [self.finishedLines removeObject:self.selectedLine];

    // Redraw everything
    [self setNeedsDisplay];

}

- (void)longPress:(UIGestureRecognizer *)gestureRecognizer {

    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {

        CGPoint point = [gestureRecognizer locationInView:self];
        self.selectedLine = [self lineAtPoint:point];

        if (self.selectedLine) {
            [self.linesInProgress removeAllObjects];
        }

    } else if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
        self.selectedLine = nil;
    }

    [self setNeedsDisplay];

}

- (void)moveLine:(UIPanGestureRecognizer *)gr {

    // If we have not selected a line, we do not do anything here
    if (!self.selectedLine) {
        return;
    }

    // When the pan recognizer changes its position...
    if (gr.state == UIGestureRecognizerStateChanged) {
        // How far has the pan moved?
        CGPoint translation = [gr translationInView:self];

        // Add the translation to the current beginning and end points of the line
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;

        // Set the new beginning and end points of the line
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;

        // Redraw the screen
        [self setNeedsDisplay];

        [gr setTranslation:CGPointZero inView:self];
    }

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }

    return NO;
}

- (int)numberOfLines {
    
    int count;
    
    // Check that they are non-nil before we add their counts...
    if (self.linesInProgress && self.finishedLines) {
        count = [self.linesInProgress count] + [self.finishedLines count];
    }
    
    return count;
    
}

@end
