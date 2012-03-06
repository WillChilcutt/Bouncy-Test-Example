//
//  BouncyView.m
//  Bouncy
//
//  Created by Will Chilcutt on 3/6/12.
//  Copyright (c) 2012 ETSU. All rights reserved.
//

#import "BouncyView.h"

#import "BouncyViewController.h"

@implementation BouncyView

@synthesize _ourViewController;

- (void)drawRect:(CGRect)dirtyRect
{
    NSInteger numberOfBalls = [_ourViewController askModelForNumberOfBalls];

    [[NSColor blackColor] setStroke];

    if ( [_ourViewController askModelForWrapping] == NO )
    {
        NSBezierPath* framePath = [NSBezierPath bezierPathWithRect: [self bounds]];

        [framePath stroke];
    }

    for ( NSInteger ballIndex = 0; ballIndex < numberOfBalls; ballIndex++ )
    {
        CGRect ballBounds = [_ourViewController askModelForBallBounds:ballIndex];
        NSColor* ballColor = [_ourViewController askModelForBallColor:ballIndex];

        [ballColor setFill];

        NSBezierPath* circlePath = [NSBezierPath bezierPathWithOvalInRect: ballBounds];

        [circlePath setLineWidth:(CGFloat)4.0];

        [circlePath fill];

        [circlePath stroke];
    }
}

@end
