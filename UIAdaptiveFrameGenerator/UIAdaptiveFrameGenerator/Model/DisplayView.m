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
    NSPoint _pointInView;
    NSPoint _pointInWindow;
    
    NSRect _originalRect;
    
    NSTrackingArea *_trackArea;
    
    BOOL _resizeActive;
}
@end

@implementation DisplayView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _resizeActive = NO;
        // Initialization code here.
    }
    return self;
}

-(void)mouseDown:(NSEvent *)pTheEvent {
    _originalRect = self.frame;
    
    NSPoint tvarMouseInWindow = [pTheEvent locationInWindow];
    NSPoint tvarMouseInView   = [self convertPoint:tvarMouseInWindow
                                          fromView:nil];
    _pointInWindow = tvarMouseInWindow;
    _pointInView = tvarMouseInView;
    
    NSLog(@"window: %f %f", tvarMouseInWindow.x, tvarMouseInWindow.y);
    NSLog(@"view: %f %f", tvarMouseInView.x, tvarMouseInView.y);
//    NSSize zDragOffset = NSMakeSize(0.0, 0.0);
//    NSPasteboard *zPasteBoard;
    
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
    _resizeActive = YES;
    NSLog(@"%s", __func__);
}

- (void)mouseExited:(NSEvent *)theEvent
{
    NSLog(@"%s", __func__);
}

- (void)mouseUp:(NSEvent *)theEvent
{
    _resizeActive = NO;
}

-(void)mouseDragged:(NSEvent *)pTheEvent {
    NSPoint winPoint = [pTheEvent locationInWindow];
    if (_resizeActive)
    {
        NSPoint offset = NSMakePoint(winPoint.x - _pointInWindow.x, winPoint.y - _pointInWindow.y);
        NSLog(@"offset: %f %f", offset.x, offset.y);
        NSPoint curOrigin = _originalRect.origin;
        curOrigin.y += offset.y;
        NSSize curSize = _originalRect.size;
        curSize.height -= offset.y;
        curSize.width += offset.x;
        
        [self setFrameOrigin:curOrigin];
        [Utility sharedUtility].currentOpViewOrigin = curOrigin;
        
        [self setFrameSize:curSize];
        [Utility sharedUtility].currentOpViewSize = curSize;
    }
    else
    {
        NSPoint superPoint = [[self superview] convertPoint:winPoint fromView:nil];
        superPoint.x -= _pointInView.x;
        superPoint.y -= _pointInView.y;
        [self setFrameOrigin:superPoint];
        [Utility sharedUtility].currentOpViewOrigin = superPoint;
    }
    [self setNeedsDisplay:YES];
}

- (NSRect)rightDownCornerRect
{
    NSSize rectSize = NSMakeSize(10, 10);
    NSRect rect = NSMakeRect(self.bounds.size.width - rectSize.width, 0, 0, 0);
    rect.size = rectSize;
    return rect;
}

- (void)resetCursorRects
{
    NSCursor *resizeCursor = [NSCursor dragCopyCursor];
    [self addCursorRect:[self rightDownCornerRect] cursor:resizeCursor];
}

- (void)updateTrackingAreas
{
    if (_trackArea)
    {
        [self removeTrackingArea:_trackArea];
        _trackArea = nil;
    }
    int opt = NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways;
    _trackArea = [[NSTrackingArea alloc] initWithRect:[self rightDownCornerRect]
                                              options:opt
                                                owner:self
                                             userInfo:nil];
    [self addTrackingArea:_trackArea];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];

//    CGFloat r = arc4random() % 255 / 255.0;
//    CGFloat g = arc4random() % 255 / 255.0;
//    CGFloat b = arc4random() % 255 / 255.0;
//    [[NSColor colorWithCalibratedRed:r green:g blue:b alpha:0.6f] setFill];
    
    [[NSColor whiteColor] setFill];

    NSRectFill(dirtyRect);
    [NSBezierPath fillRect:dirtyRect];
 
}
@end
