//
//  BouncyViewController.m
//  Bouncy
//
//  Created by Will Chilcutt on 3/6/12.
//  Copyright (c) 2012 ETSU. All rights reserved.
//

#import "BouncyViewController.h"

@implementation BouncyViewController

@synthesize _ourView;

-(void)awakeFromNib
{
    _ourModel = [[BouncyModel alloc] initWithBounds:[_ourView bounds]];

    _timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/30.0)
                                              target:self
                                            selector:@selector(timerFireMethod:)
                                            userInfo:nil
                                             repeats:YES];

    [_ourModel createAndAddNewBall];

    _running = YES;
}

- (void)dealloc
{
    [_ourModel release];
    [_timer invalidate];
    [_timer release];
    [super dealloc];
}

-(NSInteger)askModelForNumberOfBalls
{
    return [_ourModel numberOfBalls];
}

-(CGRect)askModelForBallBounds:(NSInteger) whichBall
{
    return [_ourModel ballBounds:whichBall];
}

-(NSColor*)askModelForBallColor:(NSInteger) whichBall
{
    return [_ourModel ballColor:whichBall];
}

-(BOOL)askModelForWrapping
{
    return [_ourModel wrapping];
}

-(IBAction)wrapCheckBoxPressed:(NSButton*)sender
{
    [_ourModel wrapping:[sender state]];
}

-(IBAction)ballsSliderMoved:(NSSlider*)sender
{
    NSInteger numBalls = [sender intValue];
    [_ourModel changeNumberOfBalls:numBalls];
}

-(IBAction)speedSliderMoved:(NSSlider*)sender
{
    [_timer invalidate];

    _timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/[sender doubleValue])
                                              target:self
                                            selector:@selector(timerFireMethod:)
                                            userInfo:nil
                                             repeats:YES];

}

-(IBAction)startStopButtonPressed:(NSButton*)sender
{
    _running = !_running;

    if (_running)
    {
        [sender setTitle:@"Stop"];
    }
    else
    {
        [sender setTitle:@"GO!"];
    }
}

-(void)timerFireMethod:(NSTimer*)theTimer
{
    if ( _running == true )
    {
        [_ourModel handleCollisions];
        [_ourModel updateBallPositions];
        [_ourView setNeedsDisplay:YES];
    }
}
@end
