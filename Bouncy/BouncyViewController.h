//
//  BouncyViewController.h
//  Bouncy
//
//  Created by Will Chilcutt on 3/6/12.
//  Copyright (c) 2012 ETSU. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "BouncyView.h"
#import "BouncyModel.h"

@interface BouncyViewController : NSViewController
{
@private
    BouncyView* _ourView;
    BouncyModel* _ourModel;
    NSTimer* _timer;
    BOOL _running;
}

@property (retain) IBOutlet BouncyView* _ourView;

-(NSInteger)askModelForNumberOfBalls;
-(CGRect)askModelForBallBounds:(NSInteger) whichBall;
-(NSColor*)askModelForBallColor:(NSInteger) whichBall;
-(IBAction)ballsSliderMoved:(NSSlider*)sender;
-(IBAction)speedSliderMoved:(NSSlider*)sender;
-(IBAction)startStopButtonPressed:(NSButton*)sender;
-(IBAction)wrapCheckBoxPressed:(NSButton*)sender;
-(BOOL)askModelForWrapping;
@end
