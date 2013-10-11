//
//  AdapterWindow.m
//  UIAdaptiveFrameGenerator
//
//  Created by wyq on 13-9-25.
//  Copyright (c) 2013年 cloudayc. All rights reserved.
//

#import "AdapterWindow.h"
#import "AdapterView.h"
#import "Utility.h"
#import "DisplayView.h"

@implementation AdapterWindow

- (void)awakeFromNib
{
    _screens = [NSMutableArray array];
}

- (IBAction)addScreen:(id)sender
{
    NSInteger width = [txt_w.stringValue integerValue];
    NSInteger height = [txt_h.stringValue integerValue];
    NSInteger topEdge = 10;
    NSInteger margin = 10;
    NSRect frame = NSMakeRect(menuView.frame.origin.x + menuView.frame.size.width + margin, topEdge, width, height);
    
    AdapterView *view = [[AdapterView alloc] initWithFrame:frame];
    [view setWantsLayer:YES];
    view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    view.layer.borderColor = [[NSColor lightGrayColor] CGColor];
    view.layer.borderWidth = 3.f;
    [self.contentView addSubview:view];
    
    [_screens addObject:view];
    
    [self adjustWindowAnimatedWithViewFrame:view.frame];
}

- (void)adjustWindowAnimatedWithViewFrame:(CGRect)frame
{
    NSInteger margin = 10;
    NSSize newSize = NSMakeSize(frame.origin.x + frame.size.width + margin,
                                frame.origin.y + frame.size.height + margin);
    if ([self frame].size.width < newSize.width
        || [self frame].size.height < newSize.height)
    {
        NSRect windowFrame = self.frame;
        windowFrame.size.width = MAX(windowFrame.size.width, newSize.width);
        windowFrame.size.height = MAX(windowFrame.size.height, newSize.height);
        [NSAnimationContext beginGrouping];
        [[NSAnimationContext currentContext] setDuration:1.f];
        [self setFrame:windowFrame display:YES animate:YES];
        [NSAnimationContext endGrouping];
        
        [self setContentMaxSize:windowFrame.size];
    }
}

- (IBAction)addDisplayView:(id)sender
{
    for (AdapterView *screen in _screens)
    {
        DisplayView *view = [[DisplayView alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
        [screen addSubview:view];
    }
}

- (IBAction)addAdaptiveRootView:(id)sender
{
    static int n = 50;
    NSSize wSize = [self.contentView bounds].size;
//    NSRect frame = NSMakeRect(drawPoint.x + n, drawPoint.y + wSize.height - n, 50, 50);
//    [self addAdaptiveView:frame];
    n += 30;
}

-(void)mouseDown:(NSEvent *)pTheEvent
{
    NSLog(@"%s", __func__);
}

- (void)addAdaptiveView:(CGRect)frame
{
    AdapterView *subview = [[AdapterView alloc] initWithFrame:frame];
    [self.contentView addSubview:subview];
}

@end
