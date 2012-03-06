//
//  BouncyTest.m
//  BouncyTest
//
//  Created by Will Chilcutt on 3/6/12.
//  Copyright (c) 2012 ETSU. All rights reserved.
//

#import "BouncyTest.h"

#import "BouncyModel.h"

@implementation BouncyTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NSRect bounds = NSMakeRect(0, 0, 512, 512);
    BouncyModel *model = [[BouncyModel alloc] initWithBounds:bounds];
    STAssertNotNil(model , @"The model was nil (alloc/init)");
    
}

-(void)testBad
{
    NSRect bounds = NSMakeRect(0, 0, -512, -512);
    BouncyModel *model = [[BouncyModel alloc] initWithBounds:bounds];
    STAssertNotNil(model , @"The model was nil (alloc/init)");
    
}

@end
