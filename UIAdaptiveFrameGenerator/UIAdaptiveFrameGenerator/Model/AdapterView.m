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

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
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
    
    NSLog(@"Error MyNSView performDragOperation");
    return NO;
    
}


-(void)mouseDragged:(NSEvent *)pTheEvent {
    [self setNeedsDisplay:YES];
}

- (void)concludeDragOperation:(id )sender {
    [self setNeedsDisplay:YES];
}


- (void)moveDisplayView
{
    for (AdapterView *v in self.subviews)
    {
        NSRect frame = v.frame;
        frame.origin.x += 2;
        [v setFrame:frame];
    }
}


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


@end
