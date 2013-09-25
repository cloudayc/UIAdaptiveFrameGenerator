//
//  AdapterWindow.m
//  UIAdaptiveFrameGenerator
//
//  Created by wyq on 13-9-25.
//  Copyright (c) 2013年 cloudayc. All rights reserved.
//

#import "AdapterWindow.h"
#import "AdapterView.h"

@implementation AdapterWindow

static NSPoint drawPoint = {200, 50};

- (IBAction)addAdaptiveRootView:(id)sender
{
    static int n = 50;
    NSSize wSize = [self.contentView bounds].size;
    NSRect frame = NSMakeRect(n, wSize.height - n, 50, 50);
    [self addAdaptiveView:frame];
    n += 30;
}

- (void)addAdaptiveView:(CGRect)frame
{
    AdapterView *subview = [[AdapterView alloc] initWithFrame:frame];
//    self.contentView.l.anchorPoint = NSMakePoint(1.f, 1.f);
    [self.contentView addSubview:subview];
}

@end
