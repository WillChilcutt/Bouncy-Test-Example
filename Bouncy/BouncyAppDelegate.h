//
//  BouncyAppDelegate.h
//  Bouncy
//
//  Created by Glenn Sugden on 2011.08.02.
//  Copyright 2011 UC:Berkeley. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BouncyAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
