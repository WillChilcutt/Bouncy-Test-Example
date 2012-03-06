//
//  BouncyModel.m
//  Bouncy
//
//
//  Created by Will Chilcutt on 3/6/12.
//  Copyright (c) 2012 ETSU. All rights reserved.
//
#import "BouncyModel.h"

const NSInteger kBallSize = 48;

@interface Ball : NSObject
{
@private
    NSInteger _xPosition;
    NSInteger _yPosition;
    NSInteger _xVelocity;
    NSInteger _yVelocity;
    NSInteger _size;
    NSColor* _color;
}

@property (assign) NSInteger _xPosition;
@property (assign) NSInteger _yPosition;
@property (assign) NSInteger _xVelocity;
@property (assign) NSInteger _yVelocity;
@property (assign) NSInteger _size;
@property (retain) NSColor* _color;

-(id)initWithXPosition:(NSInteger)xPos yPosition:(NSInteger)yPos
             xVelocity:(NSInteger)xVel yVelocity:(NSInteger)yVel;
-(void)updatePositionInBounds:(CGRect)bounds withWrapping:(BOOL)wrapON;
-(CGRect)bounds;

@end

@implementation Ball

@synthesize _xPosition;
@synthesize _yPosition;
@synthesize _xVelocity;
@synthesize _yVelocity;
@synthesize _size;
@synthesize _color;

-(id)initWithXPosition:(NSInteger)xPos yPosition:(NSInteger)yPos
             xVelocity:(NSInteger)xVel yVelocity:(NSInteger)yVel
{
    self = [super init];

    if (self)
    {
        _xPosition = xPos;
        _yPosition = yPos;

        _xVelocity = xVel;
        _yVelocity = yVel;

        _color = [NSColor colorWithSRGBRed:((random()%100)/100.0) green:((random()%100)/100.0)  blue:((random()%100)/100.0)  alpha:1.0];

        _size = ( random() % ( kBallSize / 2 ) ) + ( kBallSize / 2 );
    }
    return (self);
}

-(void)updatePositionInBounds:(CGRect)bounds withWrapping:(BOOL)wrapON
{
    NSInteger leftEdge = bounds.origin.x;
    NSInteger topEdge = bounds.origin.y;
    NSInteger rightEdge = ( bounds.origin.x + bounds.size.width );
    NSInteger bottomEdge = ( bounds.origin.x + bounds.size.height );

    _xPosition += _xVelocity;
    _yPosition += _yVelocity;

    if (wrapON == NO)
    {
        if ( ((_xPosition + _size) > rightEdge) || (_xPosition < leftEdge) )
        {
            _xVelocity = -_xVelocity;
            _xPosition += _xVelocity;
        }

        if ( ((_yPosition + _size) > bottomEdge) || (_yPosition < topEdge) )
        {
            _yVelocity = -_yVelocity;
            _yPosition += _yVelocity;
        }
    }
    else
    {
        if ( _xPosition > rightEdge )
        {
            _xPosition = leftEdge;
        }
        else if (_xPosition < leftEdge )
        {
            _xPosition = rightEdge;
        }

        if ( _yPosition > bottomEdge )
        {
            _yPosition = topEdge;
        }
        else if (_yPosition < topEdge)
        {
            _yPosition = bottomEdge;
        }
    }
}

-(CGRect)bounds
{
    CGRect boundsRect = CGRectMake(_xPosition,_yPosition,_size,_size);

    return(boundsRect);
}

@end

@implementation BouncyModel

-(id)initWithBounds:(CGRect)rect
{
    self = [super init];
    if (self)
    {
        _balls = [[NSMutableArray alloc] init];
        _bounds = rect;
        _wrap = NO;
    }
    if(_bounds.size.height <0 || _bounds.size.width <0)
        self=nil;
    return self;
}

-(NSInteger)numberOfBalls
{
    return [_balls count];
}

-(CGRect)ballBounds:(NSInteger)whichBall
{
    return [[_balls objectAtIndex:whichBall] bounds];
}

-(NSColor*)ballColor:(NSInteger) whichBall
{
    return [[_balls objectAtIndex:whichBall] _color];
}

-(void)wrapping:(BOOL)wrapOn
{
    _wrap = wrapOn;
}

-(BOOL)wrapping
{
    return _wrap;
}

-(void)updateBallPositions
{
    for ( Ball* aBall in _balls )
    {
        [aBall updatePositionInBounds:_bounds withWrapping:_wrap];
    }
}

-(void)createAndAddNewBall
{
    Ball* newBall;

    NSInteger leftEdge = _bounds.origin.x;
    NSInteger topEdge = _bounds.origin.y;
    NSInteger rightEdge = ( _bounds.origin.x + _bounds.size.width );
    NSInteger bottomEdge = ( _bounds.origin.x + _bounds.size.height );

    NSInteger _xPosition;
    NSInteger _yPosition;

    do
    {
        _xPosition = ( random( ) % ( rightEdge - leftEdge - kBallSize ) ) + leftEdge;
        _yPosition = ( random( ) % ( bottomEdge - topEdge - kBallSize ) ) + topEdge;
    }
    while ([self CheckCollisionWith:_xPosition andWith:_yPosition using:-1]);

    NSInteger _xVelocity;
    NSInteger _yVelocity;

    do
    {
        _xVelocity = ( ( random( ) % 800 ) - 400 ) / 100;
        _yVelocity = ( ( random( ) % 800 ) - 400 ) / 100;
    }
    while((_xVelocity==0) || (_yVelocity==0));

    newBall = [[Ball alloc] initWithXPosition:_xPosition yPosition:_yPosition
                                     xVelocity:_xVelocity yVelocity:_yVelocity];
    [_balls addObject:newBall];

}

-(void)changeNumberOfBalls:(NSInteger)newNumberOfBalls
{
    NSInteger differenceInBallCount = newNumberOfBalls - [_balls count];

    if ( differenceInBallCount < 0 )
    {
        while ( ( differenceInBallCount++ ) < 0 )
        {
            [_balls removeObjectAtIndex:0];
        }
    }
    else
    {
        while ( differenceInBallCount-- )
        {
            [self createAndAddNewBall];
        }
    }
}

-(void)handleCollisions
{
    if ( [_balls count] > 1 )
    {
        for (NSInteger ballIndex = 0; ballIndex < [_balls count]; ballIndex ++)
        {
            Ball* ball = [_balls objectAtIndex:ballIndex];

            NSInteger futurePositionX = ball._xPosition + ball._xVelocity;
            NSInteger futurePositionY = ball._yPosition + ball._yVelocity;

            if ([self CheckCollisionWith:futurePositionX andWith:futurePositionY using:ballIndex])
            {
                NSInteger futureVerticleX = ball._xPosition;
                NSInteger futureVerticleY = ball._yPosition + ball._yVelocity;

                if ([self CheckCollisionWith:futureVerticleX andWith:futureVerticleY using:ballIndex])
                {
                    ball._yVelocity = -ball._yVelocity;
                }

                NSInteger futureHorizontalX = ball._xPosition + ball._xVelocity;
                NSInteger futureHorizontalY = ball._yPosition;

                if ([self CheckCollisionWith:futureHorizontalX
                                     andWith:futureHorizontalY using:ballIndex])
                {
                    ball._xVelocity = -ball._xVelocity;
                }
            }
        }
    }
}

-(BOOL)CheckCollisionWith:(NSInteger)futureX andWith:(NSInteger)futureY using:(NSInteger)thisBallIndex
{
    NSInteger left = futureX;
    NSInteger bottom = futureY;
    NSInteger right = futureX + kBallSize;
    NSInteger top = futureY + kBallSize;

    for (NSInteger ballIndex = 0; ballIndex < [_balls count]; ballIndex ++)
    {
        if ( ballIndex != thisBallIndex )
        {
            CGRect checkBallRect = [self ballBounds:ballIndex];

            NSInteger checkLeft = checkBallRect.origin.x;
            NSInteger checkBottom = checkBallRect.origin.y;
            NSInteger checkRight = checkBallRect.origin.x + checkBallRect.size.width;
            NSInteger checkTop = checkBallRect.origin.y + checkBallRect.size.height;

            if (right <= checkLeft)
            {
                continue;
            }
            else
            {
                if (left >= checkRight)
                {
                    continue;
                }
                else
                {
                    if (top <= checkBottom)
                    {
                        continue;
                    }
                    else
                    {
                        if (bottom >= checkTop)
                        {
                            continue;
                        }
                        else
                        {
                            return YES;
                        }
                    }
                }
            }
        }
    }
    return NO;
}

@end
