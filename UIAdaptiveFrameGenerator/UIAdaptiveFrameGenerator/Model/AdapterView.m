//
//  AdapterView.m
//  UIAdaptiveFrameGenerator
//
//  Created by wyq on 13-9-25.
//  Copyright (c) 2013年 cloudayc. All rights reserved.
//

#import "AdapterView.h"

@implementation AdapterView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    
    CGFloat r = arc4random() % 255 / 255.0;
    CGFloat g = arc4random() % 255 / 255.0;
    CGFloat b = arc4random() % 255 / 255.0;
    [[NSColor colorWithCalibratedRed:r green:g blue:b alpha:0.6f] setFill];
    
//    [[NSColor yellowColor] set];
//    NSRectFill(dirtyRect);
    [NSBezierPath fillRect:dirtyRect];
    // Drawing code here.
}

@end
