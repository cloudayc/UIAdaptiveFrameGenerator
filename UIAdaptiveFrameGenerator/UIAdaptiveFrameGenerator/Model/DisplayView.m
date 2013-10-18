//
//  DisplayView.m
//  UIAdaptiveFrameGenerator
//
//  Created by wyq on 13-10-10.
//  Copyright (c) 2013年 cloudayc. All rights reserved.
//

#import "DisplayView.h"
#import "Utility.h"

@interface DisplayView()
{
    NSPoint _relativePoint;
}
@end

@implementation DisplayView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(void)mouseDown:(NSEvent *)pTheEvent {
    
    NSPoint tvarMouseInWindow = [pTheEvent locationInWindow];
    NSPoint tvarMouseInView   = [self convertPoint:tvarMouseInWindow
                                          fromView:nil];
    _relativePoint = tvarMouseInView;
    
    NSLog(@"window: %f %f", tvarMouseInWindow.x, tvarMouseInWindow.y);
    NSLog(@"view: %f %f", tvarMouseInView.x, tvarMouseInView.y);
    NSSize zDragOffset = NSMakeSize(0.0, 0.0);
    NSPasteboard *zPasteBoard;
    
//    zPasteBoard = [NSPasteboard pasteboardWithName:NSDragPboard];
//    [zPasteBoard declareTypes:[NSArray arrayWithObject:NSTIFFPboardType]
//                        owner:self];
//    [zPasteBoard setData:[self.nsImageObj TIFFRepresentation]
//                 forType:NSTIFFPboardType];
//    
//    [self dragImage:self.nsImageObj
//                 at:tvarMouseInView
//             offset:zDragOffset
//              event:pTheEvent
//         pasteboard:zPasteBoard
//             source:self
//          slideBack:YES];
    
    
}
- (void)mouseMoved:(NSEvent *)theEvent
{
    NSLog(@"%s", __func__);
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    NSLog(@"%s", __func__);
}

- (void)mouseExited:(NSEvent *)theEvent
{
    NSLog(@"%s", __func__);
}


-(void)mouseDragged:(NSEvent *)pTheEvent {
    NSPoint winPoint = [pTheEvent locationInWindow];
    NSPoint superPoint = [[self superview] convertPoint:winPoint fromView:nil];
    superPoint.x -= _relativePoint.x;
    superPoint.y -= _relativePoint.y;
    [self setFrameOrigin:superPoint];
    [Utility sharedUtility].currentOpViewOrigin = superPoint;
    [self setNeedsDisplay:YES];
}


- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];

    CGFloat r = arc4random() % 255 / 255.0;
    CGFloat g = arc4random() % 255 / 255.0;
    CGFloat b = arc4random() % 255 / 255.0;
    [[NSColor colorWithCalibratedRed:r green:g blue:b alpha:0.6f] setFill];

    NSRectFill(dirtyRect);
    [NSBezierPath fillRect:dirtyRect];
 
}
@end
