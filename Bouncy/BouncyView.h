//
//  BouncyView.h
//  Bouncy
//
//  Created by Will Chilcutt on 3/6/12.
//  Copyright (c) 2012 ETSU. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class BouncyViewController;

@interface BouncyView : NSView
{
@private
    BouncyViewController* _ourViewController;
}
@property (retain) IBOutlet BouncyViewController* _ourViewController;
@end
