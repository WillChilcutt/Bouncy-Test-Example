//
//  BouncyModel.h
//  Bouncy
//
//  Created by Will Chilcutt on 3/6/12.
//  Copyright (c) 2012 ETSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BouncyModel : NSObject
{
@private
    NSMutableArray* _balls;
    CGRect _bounds;
    BOOL _wrap;
}
-(id)initWithBounds:(CGRect)rect;
-(NSInteger)numberOfBalls;
-(CGRect)ballBounds:(NSInteger)whichBall;
-(NSColor*)ballColor:(NSInteger) whichBall;
-(void)updateBallPositions;
-(void)createAndAddNewBall;
-(void)changeNumberOfBalls:(NSInteger)newNumberOfBalls;
-(void)handleCollisions;
-(BOOL)CheckCollisionWith:(NSInteger)futureX andWith:(NSInteger)futureY using:(NSInteger)thisBallIndex;
-(void)wrapping:(BOOL)wrapOn;
-(BOOL)wrapping;
@end
