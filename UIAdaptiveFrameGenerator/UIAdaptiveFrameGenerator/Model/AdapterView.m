//
//  AdapterView.m
//  UIAdaptiveFrameGenerator
//
//  Created by wyq on 13-9-25.
//  Copyright (c) 2013年 cloudayc. All rights reserved.
//

#import "AdapterView.h"

@interface AdapterView()

@property (nonatomic, strong) NSImage *nsImageObj;

@end

@implementation AdapterView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerForDraggedTypes:[NSArray arrayWithObjects:NSTIFFPboardType,NSFilenamesPboardType, nil]];
    }
    return self;
}

- (NSDragOperation)draggingEntered:(id )sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask])
        == NSDragOperationGeneric) {
        
        return NSDragOperationGeneric;
        
    }
    
    // not a drag we can use
    return NSDragOperationNone;
    
}

- (BOOL)prepareForDragOperation:(id )sender {
    return YES;
}

- (BOOL)performDragOperation:(id )sender {
    NSPasteboard *zPasteboard = [sender draggingPasteboard];
    // define the images  types we accept
    // NSPasteboardTypeTIFF: (used to be NSTIFFPboardType).
    // NSFilenamesPboardType:An array of NSString filenames
    NSArray *zImageTypesAry = [NSArray arrayWithObjects:
                               NSPasteboardTypeTIFF,
                               NSFilenamesPboardType,
                               nil];
    
    NSString *zDesiredType = [zPasteboard availableTypeFromArray:zImageTypesAry];
    
    if ([zDesiredType isEqualToString:NSPasteboardTypeTIFF]) {
        NSData *zPasteboardData   = [zPasteboard dataForType:zDesiredType];
        if (zPasteboardData == nil) {
            NSLog(@"Error: MyNSView zPasteboardData == nil");
            return NO;
        } // end if
        
        
        self.nsImageObj = [[NSImage alloc] initWithData:zPasteboardData];
        [self setNeedsDisplay:YES];
        return YES;
        
    } //end if
    
    
    if ([zDesiredType isEqualToString:NSFilenamesPboardType]) {
        // the pasteboard contains a list of file names
        //Take the first one
        NSArray *zFileNamesAry = [zPasteboard propertyListForType:@"NSFilenamesPboardType"];
        NSString *zPath = [zFileNamesAry objectAtIndex:0];
        NSImage *zNewImage = [[NSImage alloc] initWithContentsOfFile:zPath];
        
        if (zNewImage == nil) {
            NSLog(@"Error: MyNSView performDragOperation zNewImage == nil");
            return NO;
        }
        
        self.nsImageObj = zNewImage;
        [_nsImageObj setScalesWhenResized:YES];
        NSSize size = {_nsImageObj.size.width / (_nsImageObj.size.width / self.frame.size.width),
                    _nsImageObj.size.height / (_nsImageObj.size.width / self.frame.size.width)};
        [_nsImageObj setSize:size];
        
        [self setNeedsDisplay:YES];
        return YES;
        
    }
    
    //this cant happen ???
    NSLog(@"Error MyNSView performDragOperation");
    return NO;
    
} // end performDragOperation


- (void)concludeDragOperation:(id )sender {
    [self setNeedsDisplay:YES];
} // end concludeDragOperation



- (void)drawRect:(NSRect)dirtyRect {
    if (self.nsImageObj == nil) {
        [[NSColor blackColor] set];
        NSRectFill( dirtyRect );
    }
    
	NSRect zOurBounds = [self bounds];
    [super drawRect:dirtyRect];
    
    zOurBounds.origin.x = (self.frame.size.width - _nsImageObj.size.width) / 2;
    [_nsImageObj drawAtPoint:zOurBounds.origin
                    fromRect:dirtyRect
                   operation:NSCompositeSourceOver
                    fraction:1.f];
}

//- (void)drawRect:(NSRect)dirtyRect
//{
//	[super drawRect:dirtyRect];
//    
//    CGFloat r = arc4random() % 255 / 255.0;
//    CGFloat g = arc4random() % 255 / 255.0;
//    CGFloat b = arc4random() % 255 / 255.0;
//    [[NSColor colorWithCalibratedRed:r green:g blue:b alpha:0.6f] setFill];
//    
//    NSRectFill(dirtyRect);
//    [NSBezierPath fillRect:dirtyRect];
//    
//    // Drawing code here.
//}

@end
